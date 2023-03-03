# cl-web-starter (WIP)
Starter kit for web development using Common Lisp

## Requirements

[Roswell](https://github.com/roswell/roswell) and [Qlot](https://github.com/fukamachi/qlot) are required. For other libraries, see [qlfile](/qlfile).

## Setup

```bash
$ ros install qlot
$ qlot install
```
## Lake tasks

### Start server
```bash
$ .qlot/bin/lake server
```

### Run test
```bash
$ .qlot/bin/lake spec
```

## Roadmap

- [ ] Setup database with Mito
- [ ] Implement simple CRUD operations
- [ ] Add test suite for CRUD operations
- [ ] Create Docker image
