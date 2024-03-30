#!/bin/bash

# Check if the argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <query>"
    exit 1
fi

# Check if the OPEN_AI_API_KEY environment variable is set
if [ -z "$OPEN_AI_API_KEY" ]; then
    echo "OPEN_AI_API_KEY environment variable is not set."
    exit 1
fi

# Combine the arguments into a query string
QUERY="$*"

# Call OpenAI's API to get the command suggestion
RESPONSE=$(curl -s -X POST "https://api.openai.com/v1/chat/completions" \
    -H "Authorization: Bearer $OPEN_AI_API_KEY" \
    -H "Content-Type: application/json" \
    --data '{
        "model": "gpt-4-0125-preview",
        "messages": [{
            "role": "system",
            "content": "Suggest a terminal command for the following task. Do not explain the command. Only return the command itself. Do not use markdown in your response."
        }, {
            "role": "user",
            "content": "'"$QUERY"'"
        }]
    }')

# Extract the command from the response
COMMAND=$(echo "$RESPONSE" | jq -r '.choices[0].message.content' 2>/dev/null)

# Check if the command is null or empty
if [ -z "$COMMAND" ] || [ "$COMMAND" == "null" ]; then
    echo "No command was suggested."
    exit 1
fi

# Present the command to the user
echo "Suggested command: $COMMAND"

# Improved user menu
while true; do
    read -p "Do you want to run this command? (yes/no/correct/exit) " RESPONSE

    case "$RESPONSE" in
        yes)
            echo "Executing: $COMMAND"
            eval "$COMMAND"
            break
            ;;
        correct)
            read -p "Enter the correct command: " CORRECTED_COMMAND
            echo "Executing: $CORRECTED_COMMAND"
            eval "$CORRECTED_COMMAND"
            break
            ;;
        no)
            echo "Command not executed."
            break
            ;;
        exit)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please enter yes, no, correct, or exit."
            ;;
    esac
done
