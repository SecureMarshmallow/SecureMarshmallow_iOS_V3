#!/bin/bash

# Run `arch -x86_64 pod install` command
arch -x86_64 pod install

# Check if the pod install command succeeded
if [ $? -eq 0 ]; then
    # Print the desired text
    echo "   ,--.   ,--.                     ,--.                       ,--.,--."
    echo "   |   \`.'   | ,--,--.,--.--. ,---.|  ,---. ,--,--,--. ,--,--.|  ||  | ,---. ,--.   ,--."
    echo "   |  |'.'|  |' ,-.  ||  .--'(  .-'|  .-.  ||        |' ,-.  ||  ||  || .-. ||  |.'.|  |"
    echo "   |  |   |  |\ '-'  ||  |   .-'  \`)  | |  ||  |  |  |\ '-'  ||  ||  |' '-' '|   .'.   |"
    echo "   \`--'   \`--' \`--\`--'`--'   \`----'`--' \`--'`--\`--\`--' \`--'`--'`--' \`---' '--'   '--'"
fi
