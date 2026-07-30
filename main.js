
// import { readdir } from 'node:fs/promises';
// import path from 'node:path';
// import { fileURLToPath, pathToFileURL } from 'node:url';
// 
// const __dirname = path.dirname(fileURLToPath(import.meta.url));
// 
// const dir = path.join(__dirname, 'plugins');
// 
// const files = await readdir(dir);
// 
// for (const file of files) {
//   if (file.endsWith('.js')) {
//     const modulePath = pathToFileURL(path.join(dir, file)).href;
//     const mod = await import(modulePath);
// 
//     console.log(`Loaded ${file}`, mod);
//   }
// }



const { Client, LocalAuth } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');

// TODO: IMPORT PLUGINS IF NOT EMPTY

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
	// TODO: INTRODUCE DEBUG MODE
	// TODO: LOG TO STDOUT
	// TODO: LOG TO /logs
	// TODO: DELIVER PUBLISH TO NATS
	// TODO: NOTIFY ON FAILURE
	
	// debug mode
	// console.log(message)
	//

	const sender = message.from;
	const fromMe = message.id.fromMe;
	const msg    = message.body;
	const normalized = msg
		.toLowerCase()
		.replace(/[^a-z0-9]/g, '');

	console.log(`From ${sender}: ${msg}`);

	if (msg === 'ping') {
		client.sendMessage(sender, 'pong');
	}

	// import this statement
	if (!fromMe && (normalized.includes('iloveyou') || normalized.includes('iloveu'))) {
	  	client.sendMessage(sender, 'I love you too! ❤️');
	}

});

// message media [UNTESTED]
client.on('message', async (msg) => {
    if (msg.hasMedia) {
        const media = await msg.downloadMedia();
        console.log("! Message has media!")
    }
});

client.initialize();
