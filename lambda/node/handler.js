exports.lambda_handler = async function (event, context) {
    const data = event['Records'][0]['body'];
    console.log(data);
};