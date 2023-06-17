# Sleepsort

> efficiently sleeping with (sub-)nanosecond precision and asm threads

## Benchmarks

With *good* numbers and *optimized* timeouts, sleepsort can achieve
similar performance as C’s `qsort`.

Example using the included array in `data.asm`:

``` bash
time ./sort # real 0.008s
time ./csort # real 0.002s
```

## Dependencies

- nasm
- gcc
- make

## Usage

``` bash
$EDITOR data.asm # edit array
$EDITOR config.asm # choose syscall/busyloop strategy
./optim.sh # find optimal sleep timeout
./sort
```

## Usefulness

None
