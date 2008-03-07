From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Fri, 07 Mar 2008 21:13:11 +0000
Subject: [hp j6xx / patch] - feedback wanted on pcmcia driver hd64461_ss.c
Message-Id: <20080307220911.3271d61d.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Probably biggest rewrite yet, took me awhile to get this stuff working. However the driver is now very stable and works well.

Compaired with the old hd64461_ss.c, this one is alot smaller and instead of creating a demux it uses IRQF_SHARED. Ive also
removed support for two sockets, since only one can handle I/O cards. The other one is handled by libpata.
Tried to add alot of comments since I really(!) lacked that in the old driver.

Also, it should take very little work to get this working for hd64465 (only one socket though), but havent had much time
to work on it. 

diff --git a/drivers/pcmcia/hd64461_ss.c b/drivers/pcmcia/hd64461_ss.c
new file mode 100644
index 0000000..a179b77
--- /dev/null
+++ b/drivers/pcmcia/hd64461_ss.c
@@ -0,0 +1,555 @@
+/*
+ * drivers/pcmcia/hd64461_ss.c
+ *
+ * PCMCIA platform driver for Hitachi HD64461 companion chip
+ * Copyright (C) 2006-2008 Kristoffer Ericson <kristoffer.ericson@gmail.com>
+ *
+ * This driver is based on hd64461_ss.c that was maintained in LinuxSH cvs before merger with mainline
+ * by
+ * COPYRIGHT (C) 2002-2005 Andriy Skulysh <askulysh@image.kiev.ua>
+ * COPYRIGHT (C) ?  Greg Banks <gbanks@pocketpenguins.com>
+ * COPYRIGHT (C) 2000 YAEGASHI Takeshi
+ *
+ * Please note that although the hd64461 chipset supports two sockets (0 & 1) this driver only
+ * supports the PCMCIA one. The CF slot cannot handle anything other than memory cards, so its
+ * better to leave that to other drivers such as pata.
+ *
+ */
+#include <linux/autoconf.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/ss.h>
+#include <pcmcia/bulkmem.h>
+#include <pcmcia/cistpl.h>
+
+#include "cs_internal.h"
+
+#include <asm/io.h>
+#include <asm/hd64461.h>
+#include <asm/hp6xx.h>
+
+#define MODNAME "HD64461_ss"
+
+typedef struct hd64461_socket_t {
+	u8			cscier;
+	unsigned int		irq;
+	unsigned long		mem_base;
+	socket_state_t		state;
+	pccard_mem_map		mem_maps[MAX_WIN];
+	unsigned char		IC_memory;
+	struct pcmcia_socket	socket;
+} hd64461_socket_t;
+
+static hd64461_socket_t hd64461_sockets[1];
+
+static int hd64461_set_voltage(int Vcc, int Vpp)
+{
+	u8 gcr, scr;
+	u16 stbcr;
+	u32 gcr_reg = HD64461_PCC0GCR;
+	u32 scr_reg = HD64461_PCC0SCR;
+
+	gcr = inb(gcr_reg);
+	scr = inb(scr_reg);
+
+	switch (Vcc) {
+	case 0:
+			gcr |= HD64461_PCCGCR_VCC0;
+			scr |= HD64461_PCCSCR_VCC1;
+			break;
+	case 33:
+			gcr |= HD64461_PCCGCR_VCC0;
+			scr &= ~HD64461_PCCSCR_VCC1;
+			break;
+	case 50:
+			gcr &= ~HD64461_PCCGCR_VCC0;
+			scr &= ~HD64461_PCCSCR_VCC1;
+			break;
+	}
+
+	outb(gcr, gcr_reg);
+	outb(scr, scr_reg);
+
+	stbcr = ctrl_inw(HD64461_STBCR);
+
+	if (Vcc > 0) {
+		stbcr &= ~HD64461_STBCR_SPC0ST;
+	} else {
+		stbcr |= HD64461_STBCR_SPC0ST;
+	}
+
+	outw(stbcr, HD64461_STBCR);
+
+	return 1;
+}
+
+static int hd64461_init(struct pcmcia_socket *s)
+{
+	u16 gpadr;
+	hd64461_socket_t *sp = container_of(s, struct hd64461_socket_t, socket);
+
+	sp->state.Vcc = 0;
+	sp->state.Vpp = 0;
+	hd64461_set_voltage(0, 0);
+
+	gpadr = ctrl_inw(HD64461_GPADR);
+	gpadr &= ~HD64461_GPADR_PCMCIA0;
+	ctrl_outw(gpadr, HD64461_GPADR);
+
+	return 0;
+}
+
+static int hd64461_suspend(struct pcmcia_socket *s)
+{
+	u16 gpadr;
+	u8 gcr;
+	u32 gcr_reg = HD64461_PCC0GCR;
+
+	gcr = inb(gcr_reg);
+	gcr &= ~HD64461_PCCGCR_DRVE;
+	ctrl_outb(gcr, gcr_reg);
+	hd64461_set_voltage(0, 0);
+
+	gpadr = ctrl_inw(HD64461_GPADR);
+	gpadr |= HD64461_GPADR_PCMCIA0;
+	ctrl_outw(gpadr, HD64461_GPADR);
+
+	return 0;
+}
+
+static int hd64461_get_status(struct pcmcia_socket *s, u32 *value)
+{
+	u8 isr;
+	u32 status = 0;
+	hd64461_socket_t *sp = container_of(s, struct hd64461_socket_t, socket);
+
+	/* get status of pcmcia socket */
+	isr = inb(HD64461_PCC0ISR);
+
+	/* is card inserted and powerd? */
+	if (!(isr & HD64461_PCCISR_PCD_MASK)) {
+		status |= SS_DETECT;
+
+		/* If its an memory card, lets find out the voltage */
+		if (sp->IC_memory) {
+			switch (isr & HD64461_PCCISR_BVD_MASK) {
+			case HD64461_PCCISR_BVD_BATGOOD:
+				break;
+			case HD64461_PCCISR_BVD_BATWARN:
+				status |= SS_BATWARN;
+				break;
+			default:
+				status |= SS_BATDEAD;
+				break;
+			}
+
+			if (isr & HD64461_PCCISR_READY) {
+				status |= SS_READY;
+			}
+
+			if (isr & HD64461_PCCISR_MWP) {
+				status |= SS_WRPROT;
+			}
+		} else {
+			status |= SS_STSCHG;
+		}
+
+		switch (~isr & (HD64461_PCCISR_VS2 | HD64461_PCCISR_VS1)) {
+		case HD64461_PCCISR_VS1:
+			/* 5V card, Implies that the card shouldn't work, but sometimes it actually does */
+			/* so we set the 3V just to give it a try */
+			status |= SS_3VCARD;
+			break;
+		case 0:
+		case HD64461_PCCISR_VS2:
+			/* This card is an ordinary 3V card */
+			status |= SS_3VCARD;
+			break;
+		case HD64461_PCCISR_VS2 | HD64461_PCCISR_VS1:
+			break;
+		}
+
+		if ((sp->state.Vcc != 0) || (sp->state.Vpp != 0)) {
+			status |= SS_POWERON;
+	}
+	}
+	*value = status;
+	return 0;
+}
+
+static int hd64461_set_socket(struct pcmcia_socket *s, socket_state_t * state)
+{
+	u32 flags;
+	u32 changed;
+	u8 gcr, cscier;
+	hd64461_socket_t *sp = container_of(s, struct hd64461_socket_t, socket);
+	u32 gcr_reg = HD64461_PCC0GCR;
+	u32 cscier_reg = HD64461_PCC0CSCIER;
+
+	local_irq_save(flags);
+
+	/* compair old power status with new */
+	if (state->Vpp != sp->state.Vpp || state->Vcc != sp->state.Vcc) {
+		if (!hd64461_set_voltage(state->Vcc, state->Vpp)) {
+			local_irq_restore(flags);
+			return -EINVAL;
+		}
+	}
+
+	/* lets only push the changes */
+	changed = sp->state.csc_mask ^ state->csc_mask;
+	cscier = ctrl_inb(cscier_reg);
+
+	/* set it so interrupt occurs when values of CD1 and CD2 are changed */
+	if (changed & SS_DETECT) {
+		if (state->csc_mask & SS_DETECT)
+			cscier |= HD64461_PCCCSCIER_CDE;
+		else
+			cscier &= ~HD64461_PCCCSCIER_CDE;
+	}
+
+	/* set so interrupt occurs when pin changes from low -> high */
+	if (changed & SS_READY) {
+		if (state->csc_mask & SS_READY)
+			cscier |= HD64461_PCCCSCIER_RE;
+		else
+			cscier &= ~HD64461_PCCCSCIER_RE;
+	}
+
+	/* set so interrupt occurs when BVD1 & BVD2 are set to bat_dead */
+	if (changed & SS_BATDEAD) {
+		if (state->csc_mask & SS_BATDEAD)
+			cscier |= HD64461_PCCCSCIER_BDE;
+		else
+			cscier &= ~HD64461_PCCCSCIER_BDE;
+	}
+
+	/* set so interrupt occurs when BVD1 & BVD2 are set to bat_warn */
+	if (changed & SS_BATWARN) {
+		if (state->csc_mask & SS_BATWARN)
+			cscier |= HD64461_PCCCSCIER_BWE;
+		else
+			cscier &= ~HD64461_PCCCSCIER_BWE;
+	}
+
+	/* set so "pccard connection" interrupt initializes PCC0SCR and PCC0GCR */
+	if (changed & SS_STSCHG) {
+		if (state->csc_mask & SS_STSCHG)
+			cscier |= HD64461_PCCCSCIER_SCE;
+		else
+			cscier &= ~HD64461_PCCCSCIER_SCE;
+	}
+
+	ctrl_outb(cscier, cscier_reg);
+
+	changed = sp->state.flags ^ state->flags;
+
+	gcr = ctrl_inb(gcr_reg);
+
+	if (changed & SS_IOCARD) {
+		if (state->flags & SS_IOCARD) {
+			if (s->sock = 1) {
+			    printk(KERN_INFO
+				       "socket 1 can be only IC Memory card\n");
+			} else {
+				/* Reset the card and set as IO card */
+				gcr |= HD64461_PCCGCR_PCCT;
+				sp->IC_memory = 0;
+			}
+		} else {
+			/* Reset and set as memory card */
+			gcr &= ~HD64461_PCCGCR_PCCT;
+			sp->IC_memory = 1;
+		}
+	}
+
+	/* if bit 3 = 0 while pccard accessed, output 1 on pccreg */
+	if (changed & SS_RESET) {
+		if (state->flags & SS_RESET)
+			gcr |= HD64461_PCCGCR_PCCR;
+		else
+			gcr &= ~HD64461_PCCGCR_PCCR;
+	}
+
+	/* Set low level of external buffer */
+	if (changed & SS_OUTPUT_ENA) {
+		if (state->flags & SS_OUTPUT_ENA)
+			gcr |= HD64461_PCCGCR_DRVE;
+		else
+			gcr &= ~HD64461_PCCGCR_DRVE;
+	}
+
+	ctrl_outb(gcr, gcr_reg);
+
+	sp->state = *state;
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int hd64461_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
+{
+	/* this is not needed due to static mappings */
+	io->start = 0xba000000;
+	io->stop  = 0xbc000000;
+
+	return 0;
+}
+
+static int hd64461_set_mem_map(struct pcmcia_socket *s,
+			       struct pccard_mem_map *mem)
+{
+	hd64461_socket_t *sp = container_of(s, struct hd64461_socket_t, socket);
+	struct pccard_mem_map *smem;
+	int map = mem->map;
+	unsigned long saddr;
+
+	if (map >= MAX_WIN)
+		return -EINVAL;
+
+	smem = &sp->mem_maps[map];
+	saddr = sp->mem_base + mem->card_start;
+
+	if (!(mem->flags & MAP_ATTRIB))
+		saddr += HD64461_PCC_WINDOW;
+
+	mem->static_start = saddr;
+
+	*smem = *mem;
+
+	return 0;
+}
+
+static struct pccard_operations hd64461_operations = {
+	.init = hd64461_init,
+	.suspend = hd64461_suspend,
+	.get_status = hd64461_get_status,
+	.set_socket = hd64461_set_socket,
+	.set_io_map = hd64461_set_io_map,
+	.set_mem_map = hd64461_set_mem_map,
+};
+
+static irqreturn_t hd64461_interrupt(int irq, void *dev)
+{
+	hd64461_socket_t *sp = (hd64461_socket_t *) dev;
+	unsigned events = 0;
+	unsigned char cscr;
+
+	cscr = ctrl_inb(HD64461_PCC0CSCR);
+
+	/* If IREQ pin is in low state */
+	if (cscr & HD64461_PCCCSCR_IREQ) {
+		cscr &= ~HD64461_PCCCSCR_IREQ;
+		/* silence interrupt source and hand over interrupt */
+		ctrl_outb(cscr, HD64461_PCC0CSCR);
+		return IRQ_NONE;
+	}
+
+	/* if both CD1 and CD2 has changed */
+	if ((cscr & HD64461_PCCCSCR_CDC)) {
+		/* silence it by writing a 0 to bit 3 */
+		cscr &= ~HD64461_PCCCSCR_CDC;
+		/* we've detected something being inserted or unplugged */
+		events |= SS_DETECT;
+
+		/* If card is ejected then cleanup */
+		if (((ctrl_inb(HD64461_PCC0ISR)) & ~HD64461_PCCISR_PCD_MASK)) {
+			cscr &= ~(HD64461_PCCCSCR_RC | HD64461_PCCCSCR_BW |
+				  HD64461_PCCCSCR_BD | HD64461_PCCCSCR_SC);
+
+		}
+	}
+
+	/* MEMORY CARD */
+	if (sp->IC_memory) {
+		if (cscr & HD64461_PCCCSCR_RC) {
+			/* ? */
+			cscr &= ~HD64461_PCCCSCR_RC;
+			events |= SS_READY;
+		}
+
+		if (cscr & HD64461_PCCCSCR_BW) {
+			/* battery warning */
+			cscr &= ~HD64461_PCCCSCR_BW;
+			events |= SS_BATWARN;
+		}
+
+		if (cscr & HD64461_PCCCSCR_BD) {
+			/* battery dead */
+			cscr &= ~HD64461_PCCCSCR_BD;
+			events |= SS_BATDEAD;
+		}
+	} else { /* IO CARD */
+		if (cscr & HD64461_PCCCSCR_SC) {
+			/* status changed */
+			cscr &= ~HD64461_PCCCSCR_SC;
+			events |= SS_STSCHG;
+		}
+	}
+	ctrl_outb(cscr, HD64461_PCC0CSCR);
+
+	/* make sure we push these changes into pcmcia events */
+	if (events)
+		pcmcia_parse_events(&sp->socket, events);
+
+	return IRQ_HANDLED;
+}
+
+int hd64461_init_socket(int sock, int irq, unsigned long mem_base,unsigned short io_offset)
+{
+	hd64461_socket_t *sp = &hd64461_sockets[sock];
+	unsigned gcr_reg = HD64461_PCC0GCR;
+	u8 gcr;
+	int i;
+
+	memset(sp, 0, sizeof(*sp));
+	sp->IC_memory = 1;
+	sp->irq = irq;
+	sp->mem_base = mem_base;
+	sp->socket.features = SS_CAP_PCCARD | SS_CAP_STATIC_MAP | SS_CAP_PAGE_REGS;
+	sp->socket.resource_ops = &pccard_static_ops;
+	sp->socket.ops = &hd64461_operations;
+	sp->socket.map_size = HD64461_PCC_WINDOW;	/* 16MB fixed window size */
+	sp->socket.pci_irq = irq;
+	sp->socket.io_offset = io_offset;
+	sp->socket.owner = THIS_MODULE;
+
+	for (i = 0; i != MAX_WIN; i++)
+		sp->mem_maps[i].map = i;
+
+	if ((request_irq(irq, hd64461_interrupt, IRQF_SHARED, "hd64461_ss-irq", sp)) < 0) {
+		printk(KERN_INFO "hd64461_init: request for irq %d: failed\n", sp->irq);
+		return -1;
+	}
+
+	gcr = inb(gcr_reg);
+	/* continuous 16MB area mode for both memory and I/O operations */
+	gcr |= HD64461_PCCGCR_PMMOD;
+	/* ??? */
+	gcr &= ~(HD64461_PCCGCR_PA25 | HD64461_PCCGCR_PA24);
+	outb(gcr, gcr_reg);
+
+	return 0;
+}
+
+void hd64461_exit_socket(int sock)
+{
+	hd64461_socket_t *sp = &hd64461_sockets[0];
+	unsigned cscier_reg = HD64461_PCC0CSCIER;
+
+	outb(0, cscier_reg);
+	hd64461_suspend(&sp->socket);
+
+}
+
+static int __devexit hd64461_pcmcia_drv_remove(struct platform_device *dev)
+{
+	/* Libpata handles CF slot (slot 1), so we only handle PCMCIA (slot 0) */
+	pcmcia_unregister_socket(&hd64461_sockets[0].socket);
+	hd64461_exit_socket(0);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int hd64461_pcmcia_drv_suspend(struct platform_device *dev, pm_message_t state)
+{
+	int ret = 0;
+	u32 cscier_reg = HD64461_PCC0CSCIER;
+
+	hd64461_sockets[0].cscier = inb(cscier_reg);
+	outb(0, cscier_reg);
+	ret = pcmcia_socket_dev_suspend(&dev->dev, state);
+
+	return ret;
+ }
+
+static int hd64461_pcmcia_drv_resume(struct platform_device *dev)
+{
+	int ret = 0;
+	u32 cscier_reg = HD64461_PCC0CSCIER;
+
+	outb(hd64461_sockets[0].cscier, cscier_reg);
+	ret = pcmcia_socket_dev_resume(&dev->dev);
+
+	return ret;
+}
+#endif
+
+static struct platform_driver hd64461_pcmcia_driver = {
+	.remove = __devexit_p(hd64461_pcmcia_drv_remove),
+#ifdef CONFIG_PM
+	.suspend = hd64461_pcmcia_drv_suspend,
+	.resume = hd64461_pcmcia_drv_resume,
+#endif
+	.driver		= {
+		.name	= "hd64461-pcmcia",
+	},
+};
+
+static struct platform_device *hd64461_pcmcia_device;
+
+static int __init init_hd64461_ss(void)
+{
+	int i;
+
+	printk(KERN_INFO "hd64461 host bridge driver\n");
+
+	if (platform_driver_register(&hd64461_pcmcia_driver))
+		return -ENODEV;
+
+	i = hd64461_init_socket(0, HD64461_IRQ_PCC0, HD64461_PCC0_BASE, 0xf000);
+	if (i < 0)
+		goto failed2;
+
+	hd64461_pcmcia_device = platform_device_alloc("hd64461-pcmcia",-1);
+	if(!hd64461_pcmcia_device) {
+		printk(KERN_INFO "hd64461_ss_init: Cannot find pcmcia host device!\n");
+		return -ENODEV;
+	}
+
+	i = platform_device_add(hd64461_pcmcia_device);
+	if (i) {
+		platform_device_put(hd64461_pcmcia_device);
+		goto failed2;
+	}
+
+	hd64461_sockets[0].socket.dev.parent = &hd64461_pcmcia_device->dev;
+
+	i = pcmcia_register_socket(&hd64461_sockets[0].socket);
+	return 0;
+
+/* Unregister driver nothing else */
+failed2:
+	printk(KERN_INFO "hd64461_ss_init: Failed to startup socket 0\n");
+	platform_driver_unregister(&hd64461_pcmcia_driver);
+	return i;
+}
+
+static void __exit exit_hd64461_ss(void)
+{
+	/* Only remove if there's something to remove */
+	if (hd64461_pcmcia_device) {
+		platform_device_unregister(hd64461_pcmcia_device);
+		platform_driver_unregister(&hd64461_pcmcia_driver);
+	}
+}
+module_init(init_hd64461_ss);
+module_exit(exit_hd64461_ss);
+
+MODULE_AUTHOR("Kristoffer Ericson <kristoffer.ericson@gmail.com>");
+MODULE_DESCRIPTION("PCMCIA driver for Hitachi HD64461 companion chip");
+MODULE_LICENSE("GPL");




-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
