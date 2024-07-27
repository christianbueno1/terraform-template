exports.handler = async (event) => {
    console.log('event', event);
    let responseMessage = 'Hello from Lambda, Christian!';

    if (event.queryStringParameters && event.queryStringParameters.name) {
        responseMessage = `Hello, ${event.queryStringParameters.name}!`;
    }

    if (event.httpMethod === 'POST') {
        responseMessage = `Hello, ${JSON.parse(event.body).name}!`;
    }

    response = {
        statusCode: 200,
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: responseMessage }),
    }
    // return {
    //     statusCode: 200,
    //     body: JSON.stringify({ message: 'Hello from Lambda!' }),
    // };
    return response
}
