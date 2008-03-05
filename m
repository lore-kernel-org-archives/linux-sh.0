From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Wed, 05 Mar 2008 21:55:09 +0000
Subject: Getting probing to work
Message-Id: <8b67d60803051355s4d498bd2mf9006e9d72409b22@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am working on a device driver for flash (the so-called "Visual
Memory Unit") on the Sega Dreamcast but I've hit a problem which, I
assume, is due to some way the device driver susbsystem works, but I
cannot see why...

These devices are hotpluggable. To determine how big they are etc I
need to pass them a message on the Dreamcast's "maple" bus and then
wait for a reply, which will contain the information I need.

If the device is plugged in before the device driver is loaded it
works like this:

System start up  --> detect device  ---> Is there a maple driver for
this function? --->

no, so load the dummy driver.

Then, when a proper device driver is loaded

We have driver for this function now  --> probe device by sending
messages---> get data needed to register for mtd subsys --> register

All fine (the dummy driver does nothing except be there)


But if I load the driver and then plug the device in, then I get this:

We have driver ---> attempt to probe  --->probe fails  --> oops


And the oops appears to be because it is impossible to send messages
to the device while inside register_driver so the result is that the
system is flooded with them as soon as the registration fails.

This is what the code looks like now - the message packet is added to
the queue and then the calling function sleeps in anticipation of a
reply. This seems to work fine when the device is already in situ but
fails on hotplugs... any clues as to why?

static void vmu_queryblocks(struct mapleq *mq)
{
	struct maple_device *mdev;
	unsigned short *res;
	struct memcard *card;

	if (!block_query_running)
		return; /* Not ready */
	block_query_running = 0;

	mdev = mq->dev;
	card = mdev->private_data;
	res = mq->recvbuf;
	card->tempA = res[12];
	card->tempB = res[6];
	
	printk("Maple: VMU device has %d user blocks with a root"
		" block at %d\n", card->tempA, card->tempB);
	wake_up_interruptible(&vmuflash_query);
}

...

	for (c = 0; c < card->partitions; c++)
	{
		/* Set the callback */
		z = 0;
		block_query_running = 1;
		do {
			z++;
			maple_getcond_callback(mdev, vmu_queryblocks, 0,
				MAPLE_FUNC_MEMCARD);
			mdev->mq->waiting = 1;
			maple_add_packet(mdev->mq);
			wait_event_interruptible_timeout(vmuflash_query,
				block_query_running = 0, HZ);
			mdev->mq->waiting = 0;
			maple_getcond_callback(mdev, NULL, 0, MAPLE_FUNC_MEMCARD);
			if (block_query_running = 0)
				break;
		} while (z < 5); /* try a few times */
		
		if (block_query_running) {
			printk(KERN_WARNING "Maple: Could not query flash "
				"memory card at (%d, %d)\n", mdev->port,
				mdev->unit);
