From: "Jeongdo Son" <sohn9086@gmail.com>
Date: Mon, 10 Mar 2008 09:55:13 +0000
Subject: Re: SH7780 / PCI1510 / CompactFlash problem
Message-Id: <59fd4ce80803100255p195b43fcs9823fdf6dd3904be@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <59fd4ce80802260259o24a82658qe93f6b9992d2e031@mail.gmail.com>
	 <56353.85.118.17.158.1204024488.squirrel@newgolddream.dyndns.info>
	 <59fd4ce80802261739n71308d6lb82720bd0e70c40a@mail.gmail.com>
In-Reply-To: <59fd4ce80802261739n71308d6lb82720bd0e70c40a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-SH <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-PCMCIA <linux-pcmcia@lists.infradead.org>

This is additional information.

I defined ATA_DEBUG and ATA_VERBOSE_DEBUG macros,
then I got the following message when I insert a Compact Flash card.

~ $ [   13.223837] pccard: PCMCIA card inserted into slot 0
[   13.225887] cs: memory probe 0x000000-0x0fffff: excluding 0x000-0xfffff
[   13.231967] cs: memory probe 0xfd000000-0xfd0fffff: excluding
0xfd000000-0xfd00ffff 0xfd020000-0xfd03ffff
[   13.249995] pcmcia: registering new device pcmcia0.0
[   13.293246] ata_host_alloc: ENTER
[   13.293639] ata_port_alloc: ENTER
[   13.295883] __ata_port_freeze: ata4294967295 port frozen
[   13.300038] scsi1 : pata_pcmcia
[   13.304416] ata1: PATA max PIO0 cmd 0xfe200200 ctl 0xfe20020e irq 67
[   13.307821] ata_host_register: probe begin
[   13.311823] ata_port_schedule_eh: port EH scheduled
[   13.315819] ata_scsi_error: ENTER
[   13.319805] ata_port_flush_task: ENTER
[   13.323540] ata_eh_link_autopsy: ENTER
[   13.323821] ata_eh_recover: ENTER
[   13.327838] __ata_port_freeze: ata1 port frozen
[   13.331819] ata_std_softreset: ENTER
[   13.335827] ata_std_softreset: about to softreset, devmask=0
[   13.339812] ata_bus_softreset: ata1: bus reset via SRST
[   13.499834] ata_std_softreset: EXIT, classes[0]=9 [1]=9
[   13.502125] ata_std_postreset: ENTER
[   13.503802] ata_std_postreset: EXIT, no device
[   13.507819] ata_eh_thaw_port: ata1 port thawed
[   13.511800] ata_eh_revalidate_and_attach: ENTER
[   13.515807] ata_eh_recover: EXIT, rc=0
[   13.519815] ata_scsi_error: EXIT
[   13.523825] ata_host_register: host probe begin
[   13.527821] ata_scsi_error: ENTER
[   13.531801] ata_port_flush_task: ENTER
[   13.535830] ata_eh_link_autopsy: ENTER
[   13.539813] ata_eh_recover: ENTER
[   13.543817] ata_eh_revalidate_and_attach: ENTER
[   13.547805] ata_eh_recover: EXIT, rc=0
[   13.551809] ata_port_schedule_eh: port EH scheduled
[   13.555976] ata_scsi_error: EXIT

~ $

Regards,
Jeongdo Son
