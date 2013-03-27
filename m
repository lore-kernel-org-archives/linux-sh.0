From: Fengguang Wu <fengguang.wu@intel.com>
Date: Wed, 27 Mar 2013 08:31:10 +0000
Subject: drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit declaration of function 'ioport_unmap'
Message-Id: <20130327083110.GB11489@localhost>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Stephane,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
commit: 2b61972b74219d21ef1e91178349bdb840357688 can: sja1000: add support for PEAK-System PCMCIA card
date:   1 year, 1 month ago
config: make ARCH=sh allyesconfig

All error/warnings:

   In file included from drivers/net/can/sja1000/peak_pcmcia.c:28:0:
   drivers/net/can/sja1000/sja1000.h:59:0: warning: "REG_SR" redefined [enabled by default]
   arch/sh/include/asm/ptrace_32.h:25:0: note: this is the location of the previous definition
   drivers/net/can/sja1000/peak_pcmcia.c: In function 'pcan_free':
>> drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
   drivers/net/can/sja1000/peak_pcmcia.c: In function 'pcan_probe':
>> drivers/net/can/sja1000/peak_pcmcia.c:672:2: error: implicit declaration of function 'ioport_map' [-Werror=implicit-function-declaration]
   drivers/net/can/sja1000/peak_pcmcia.c:672:20: warning: assignment makes pointer from integer without a cast [enabled by default]
   cc1: some warnings being treated as errors

vim +/ioport_unmap +626 drivers/net/can/sja1000/peak_pcmcia.c

2b61972b Stephane Grosjean 2012-03-02  620  
2b61972b Stephane Grosjean 2012-03-02  621  	free_irq(pdev->irq, card);
2b61972b Stephane Grosjean 2012-03-02  622  	pcan_stop_led_timer(card);
2b61972b Stephane Grosjean 2012-03-02  623  
2b61972b Stephane Grosjean 2012-03-02  624  	pcan_free_channels(card);
2b61972b Stephane Grosjean 2012-03-02  625  
2b61972b Stephane Grosjean 2012-03-02 @626  	ioport_unmap(card->ioport_addr);
2b61972b Stephane Grosjean 2012-03-02  627  
2b61972b Stephane Grosjean 2012-03-02  628  	kfree(card);
2b61972b Stephane Grosjean 2012-03-02  629  	pdev->priv = NULL;
2b61972b Stephane Grosjean 2012-03-02  630  }
2b61972b Stephane Grosjean 2012-03-02  631  
2b61972b Stephane Grosjean 2012-03-02  632  /*
2b61972b Stephane Grosjean 2012-03-02  633   * setup PCMCIA socket and probe for PEAK-System PC-CARD
2b61972b Stephane Grosjean 2012-03-02  634   */
2b61972b Stephane Grosjean 2012-03-02  635  static int __devinit pcan_probe(struct pcmcia_device *pdev)
2b61972b Stephane Grosjean 2012-03-02  636  {
2b61972b Stephane Grosjean 2012-03-02  637  	struct pcan_pccard *card;
2b61972b Stephane Grosjean 2012-03-02  638  	int err;
2b61972b Stephane Grosjean 2012-03-02  639  
2b61972b Stephane Grosjean 2012-03-02  640  	pdev->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;
2b61972b Stephane Grosjean 2012-03-02  641  
2b61972b Stephane Grosjean 2012-03-02  642  	err = pcmcia_loop_config(pdev, pcan_conf_check, NULL);
2b61972b Stephane Grosjean 2012-03-02  643  	if (err) {
2b61972b Stephane Grosjean 2012-03-02  644  		dev_err(&pdev->dev, "pcmcia_loop_config() error %d\n", err);
2b61972b Stephane Grosjean 2012-03-02  645  		goto probe_err_1;
2b61972b Stephane Grosjean 2012-03-02  646  	}
2b61972b Stephane Grosjean 2012-03-02  647  
2b61972b Stephane Grosjean 2012-03-02  648  	if (!pdev->irq) {
2b61972b Stephane Grosjean 2012-03-02  649  		dev_err(&pdev->dev, "no irq assigned\n");
2b61972b Stephane Grosjean 2012-03-02  650  		err = -ENODEV;
2b61972b Stephane Grosjean 2012-03-02  651  		goto probe_err_1;
2b61972b Stephane Grosjean 2012-03-02  652  	}
2b61972b Stephane Grosjean 2012-03-02  653  
2b61972b Stephane Grosjean 2012-03-02  654  	err = pcmcia_enable_device(pdev);
2b61972b Stephane Grosjean 2012-03-02  655  	if (err) {
2b61972b Stephane Grosjean 2012-03-02  656  		dev_err(&pdev->dev, "pcmcia_enable_device failed err=%d\n",
2b61972b Stephane Grosjean 2012-03-02  657  			err);
2b61972b Stephane Grosjean 2012-03-02  658  		goto probe_err_1;
2b61972b Stephane Grosjean 2012-03-02  659  	}
2b61972b Stephane Grosjean 2012-03-02  660  
2b61972b Stephane Grosjean 2012-03-02  661  	card = kzalloc(sizeof(struct pcan_pccard), GFP_KERNEL);
2b61972b Stephane Grosjean 2012-03-02  662  	if (!card) {
2b61972b Stephane Grosjean 2012-03-02  663  		dev_err(&pdev->dev, "couldn't allocate card memory\n");
2b61972b Stephane Grosjean 2012-03-02  664  		err = -ENOMEM;
2b61972b Stephane Grosjean 2012-03-02  665  		goto probe_err_2;
2b61972b Stephane Grosjean 2012-03-02  666  	}
2b61972b Stephane Grosjean 2012-03-02  667  
2b61972b Stephane Grosjean 2012-03-02  668  	card->pdev = pdev;
2b61972b Stephane Grosjean 2012-03-02  669  	pdev->priv = card;
2b61972b Stephane Grosjean 2012-03-02  670  
2b61972b Stephane Grosjean 2012-03-02  671  	/* sja1000 api uses iomem */
2b61972b Stephane Grosjean 2012-03-02 @672  	card->ioport_addr = ioport_map(pdev->resource[0]->start,
2b61972b Stephane Grosjean 2012-03-02  673  					resource_size(pdev->resource[0]));
2b61972b Stephane Grosjean 2012-03-02  674  	if (!card->ioport_addr) {
2b61972b Stephane Grosjean 2012-03-02  675  		dev_err(&pdev->dev, "couldn't map io port into io memory\n");

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
