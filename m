From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 03 Feb 2020 21:26:26 +0000
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
Message-Id: <00734e40-da0b-9d7f-20bc-ce1f9658dcd3@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
 <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
 <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
 <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
In-Reply-To: <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vkoul@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Geert!

On 2/3/20 9:34 PM, Geert Uytterhoeven wrote:
> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>>
>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
>> for classical SuperH hardware. It was never merged, unfortunately :(.
> 
> True.

Would it be possible to keep DMA support if device tree support was
added for SuperH? I think Rich eventually wanted to merge the patches,
there were just some minor issues with them.

It would be great if we could still get them merged. I would be happy
to help with the testing.

>>> Anyone who cares for DMA on SuperH?
>>
>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
>> essential hardware features?
> 
> It may make a few things slower.
> 
> Does any of your SuperH boards use DMA?
> Anything interesting in /proc or /sys w.r.t. DMA?

I have:

root@tirpitz:/sys> find . -iname "*dma*"
./bus/dma
./bus/dma/devices/dma0
./bus/dma/devices/dma1
./bus/dma/devices/dma2
./bus/dma/devices/dma3
./bus/dma/devices/dma4
./bus/dma/devices/dma5
./bus/dma/devices/dma6
./bus/dma/devices/dma7
./bus/dma/devices/dma8
./bus/dma/devices/dma9
./bus/dma/devices/dma10
./bus/dma/devices/dma11
./bus/platform/devices/sh_dmac
./bus/platform/devices/sh-dma-engine.0
./bus/platform/devices/sh-dma-engine.1
./devices/pci0000:00/0000:00:00.0/consistent_dma_mask_bits
./devices/pci0000:00/0000:00:00.0/dma_mask_bits
./devices/pci0000:00/0000:00:01.0/ata1/host0/scsi_host/host0/unchecked_isa_dma
./devices/pci0000:00/0000:00:01.0/ata1/link1/dev1.0/ata_device/dev1.0/dma_mode
./devices/pci0000:00/0000:00:01.0/ata2/host1/scsi_host/host1/unchecked_isa_dma
./devices/pci0000:00/0000:00:01.0/ata2/link2/dev2.0/ata_device/dev2.0/dma_mode
./devices/pci0000:00/0000:00:01.0/consistent_dma_mask_bits
./devices/pci0000:00/0000:00:01.0/dma_mask_bits
./devices/system/dma
./devices/system/dma/dma0
./devices/system/dma/dma1
./devices/system/dma/dma2
./devices/system/dma/dma3
./devices/system/dma/dma4
./devices/system/dma/dma5
./devices/system/dma/dma6
root@tirpitz:~> find /proc -iname "*dma*"
/proc/dma
/proc/irq/52/DMAC Address Error1
/proc/irq/33/DMAC Address Error0
/proc/sys/fs/nfs/idmap_cache_timeout
find: ‘/proc/5703’: No such file or directory
find: ‘/proc/5704’: No such file or directory
find: ‘/proc/5705’: No such file or directory
root@tirpitz:~> cat /proc/dma
root@tirpitz:~> find /sys -iname "*dma*"      
/sys/bus/dma
/sys/bus/dma/devices/dma0
/sys/bus/dma/devices/dma1
/sys/bus/dma/devices/dma2
/sys/bus/dma/devices/dma3
/sys/bus/dma/devices/dma4
/sys/bus/dma/devices/dma5
/sys/bus/dma/devices/dma6
/sys/bus/dma/devices/dma7
/sys/bus/dma/devices/dma8
/sys/bus/dma/devices/dma9
/sys/bus/dma/devices/dma10
/sys/bus/dma/devices/dma11
/sys/bus/platform/devices/sh_dmac
/sys/bus/platform/devices/sh-dma-engine.0
/sys/bus/platform/devices/sh-dma-engine.1
/sys/devices/pci0000:00/0000:00:00.0/consistent_dma_mask_bits
/sys/devices/pci0000:00/0000:00:00.0/dma_mask_bits
/sys/devices/pci0000:00/0000:00:01.0/ata1/host0/scsi_host/host0/unchecked_isa_dma
/sys/devices/pci0000:00/0000:00:01.0/ata1/link1/dev1.0/ata_device/dev1.0/dma_mode
/sys/devices/pci0000:00/0000:00:01.0/ata2/host1/scsi_host/host1/unchecked_isa_dma
/sys/devices/pci0000:00/0000:00:01.0/ata2/link2/dev2.0/ata_device/dev2.0/dma_mode
/sys/devices/pci0000:00/0000:00:01.0/consistent_dma_mask_bits
/sys/devices/pci0000:00/0000:00:01.0/dma_mask_bits
/sys/devices/system/dma
/sys/devices/system/dma/dma0
/sys/devices/system/dma/dma1
/sys/devices/system/dma/dma2
/sys/devices/system/dma/dma3
/sys/devices/system/dma/dma4
/sys/devices/system/dma/dma5
/sys/devices/system/dma/dma6
/sys/devices/system/dma/dma7
/sys/devices/system/dma/dma8
/sys/devices/system/dma/dma9
/sys/devices/system/dma/dma10
/sys/devices/system/dma/dma11
/sys/devices/virtual/misc/cpu_dma_latency
/sys/devices/platform/sh_dmac
/sys/devices/platform/sh_dmac/dma0
/sys/devices/platform/sh_dmac/dma1
/sys/devices/platform/sh_dmac/dma2
/sys/devices/platform/sh_dmac/dma3
/sys/devices/platform/sh_dmac/dma4
/sys/devices/platform/sh_dmac/dma5
/sys/devices/platform/sh_dmac/dma6
/sys/devices/platform/sh_dmac/dma7
/sys/devices/platform/sh_dmac/dma8
/sys/devices/platform/sh_dmac/dma9
/sys/devices/platform/sh_dmac/dma10
/sys/devices/platform/sh_dmac/dma11
/sys/devices/platform/r8a66597_hcd/usb1/1-1/1-1:1.0/host2/scsi_host/host2/unchecked_isa_dma
/sys/devices/platform/sh-dma-engine.0
/sys/devices/platform/sh-dma-engine.1
/sys/class/misc/cpu_dma_latency
/sys/module/nfs/parameters/nfs4_disable_idmapping
/sys/module/nfs/parameters/nfs_idmap_cache_timeout
/sys/module/libata/parameters/dma
/sys/module/libata/parameters/atapi_dmadir
root@tirpitz:~>

On my SH-7785LCR.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
