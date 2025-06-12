#!/bin/bash

set -e

# Check if we have at least two arguments and '--' separator
if [ "$#" -lt 3 ] || [ "$2" != "--" ]; then
  echo "Usage: $0 <number_of_versions> -- <size1> <size2> ..."
  exit 1
fi

# Read number of versions
VERSIONS=$1
shift

if [ "$1" != "--" ]; then
    echo "Error: expected -- as second argument"
    exit 1
fi
shift

# Remaining arguments are file sizes
SIZES=("$@")

# Function to convert sizes like 1kb, 2mb into bytes (1000-based)
size_to_bytes() {
  local SIZE=$1
  if [[ $SIZE =~ ^([0-9]+)([kKmMgG][bB])$ ]]; then
    NUM=${BASH_REMATCH[1]}
    UNIT=${BASH_REMATCH[2],,} # lowercase

    case $UNIT in
      kb) echo $((NUM * 1000)) ;;
      mb) echo $((NUM * 1000 * 1000)) ;;
      gb) echo $((NUM * 1000 * 1000 * 1000)) ;;
      *) echo "Invalid size unit: $UNIT" >&2; exit 1 ;;
    esac
  elif [[ $SIZE =~ ^[0-9]+$ ]]; then
    echo "$SIZE"
  else
    echo "Invalid size format: $SIZE" >&2
    exit 1
  fi
}

# Loop over versions
for VERSION in $(seq 1 $VERSIONS); do
  DIR="v$VERSION"
  mkdir -p "$DIR"
  
  for SIZE in "${SIZES[@]}"; do
    FILE="$DIR/$SIZE"
    BYTES=$(size_to_bytes "$SIZE")

    # Create file with random readableBYTES=$(size_to_bytes "$SIZE") data of specified size
    < /dev/urandom tr -dc 'a-zA-Z0-9' | head -c "$BYTES" > "$FILE"
  done
done

echo "Created ${VERSIONS} versions with files: ${SIZES[*]}"
