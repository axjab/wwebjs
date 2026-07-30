const { Client, LocalAuth } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');

// TODO: IMPORT PLUGINS

const client = new Client(
	{
		puppeteer: {
		        args: ['--no-sandbox', '--disable-setuid-sandbox'],
		    },
		authStrategy: new LocalAuth(
			{
				dataPath: '/data'
			}
		)
	}
);

client.on('ready', () => {
    console.log('CLIENT READY');
});

client.on('qr', qr => {
    qrcode.generate(qr, {small: true});
});

// Listening to all incoming messages
client.on('message_create', message => {
	// TODO: LOG TO STDOUT
	// TODO: DELIVER PUBLISH TO NATS
	// TODO: NOTIFY ON FAILURE
	
	const sender = message.from;
	const fromMe = message.id.fromMe;
	const msg    = message.body;

	console.log(`From ${sender}: ${msg}`);
	if (msg === 'ping') {
		client.sendMessage(sender, 'pong');
	}
});

client.initialize();
