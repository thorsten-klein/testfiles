# Dummy Data Test Files Repository

This repository contains automatically generated test files filled with random data.
It is useful for performance testing, benchmarking, or storage-related experiments.

## How to Use

Run the `create.sh` script to generate folders with files of various sizes:

### Example:
```bash
./create.sh 3 -- 1kb 10kb 100kb 1mb 2mb 10mb
```

This will generate the following structure:
```
v1/1kb
v1/10kb
v1/100kb
v1/1mb
v1/2mb
v1/10mb

v2/1kb
...

v3/10mb
```

## Notes

- Random data is generated using `/dev/urandom`.
- Sizes are interpreted literally (e.g., `1kb` = 1000 bytes, not 1024).
- You can modify the script to use different units or formats if needed.

## License

Public domain or do-whatever-you-want license.

