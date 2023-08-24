IREE_OPT_BINARY="/root/wang/iree/bin/iree-opt"

if [ -x "$IREE_OPT_BINARY" ]; then
    # Execute the binary with any command-line arguments passed to this script
    "$IREE_OPT_BINARY" "$@"
else
    echo "iree-opt binary not found at $IREE_OPT_BINARY"
    exit 1
fi