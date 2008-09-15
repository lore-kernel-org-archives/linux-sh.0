From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 15 Sep 2008 09:27:18 +0000
Subject: Re: Linux 2.6.22.11 on T-Engine/SH7727 (MS7727CP02) Development Kit
Message-Id: <20080915182718.e6445d99.iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
References: <loom.20080915T032055-333@post.gmane.org>
In-Reply-To: <loom.20080915T032055-333@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi ,

On Mon, 15 Sep 2008 03:48:21 +0000 (UTC)
Cuong Dang Phu <cuongdp@Cybersoft-VN.com> wrote:

> Hi,
> 
> We are working for an embedded software company, for R&D purpose, we are 
> porting Linux on T-Engine/SH7727 (MS7727CP02) Development Kit. The first step 
> we do is: define physical memory and peripherals (in this file: \include\asm-
> sh\se7727.h), but we have some difficult:
> 	a. We can’t understand many symbols: I show you a list I get form Linux 
> kernel 2.6.22.11 for se7720:
>  
> #define PA_PCIC         PA_PERIPHERAL   		/* MR-SHPC-01 PCMCIA */
> #define PA_MRSHPC       (PA_PERIPHERAL + 0x003fffe0)    /* MR-SHPC-01 PCMCIA 
> controller */
> #define PA_MRSHPC_MW1   (PA_PERIPHERAL + 0x00400000)    /* MR-SHPC-01 memory 
> window base */
> #define PA_MRSHPC_MW2   (PA_PERIPHERAL + 0x00500000)    /* MR-SHPC-01 attribute 
> window base */
> #define PA_MRSHPC_IO    (PA_PERIPHERAL + 0x00600000)    /* MR-SHPC-01 I/O 
> window base */
> #define MRSHPC_OPTION   (PA_MRSHPC + 6)
> #define MRSHPC_CSR      (PA_MRSHPC + 8)
> #define MRSHPC_ISR      (PA_MRSHPC + 10)
> #define MRSHPC_ICR      (PA_MRSHPC + 12)
> #define MRSHPC_CPWCR    (PA_MRSHPC + 14)
> #define MRSHPC_MW0CR1   (PA_MRSHPC + 16)
> #define MRSHPC_MW1CR1   (PA_MRSHPC + 18)
> #define MRSHPC_IOWCR1   (PA_MRSHPC + 20)
> #define MRSHPC_MW0CR2   (PA_MRSHPC + 22)
> #define MRSHPC_MW1CR2   (PA_MRSHPC + 24)
> #define MRSHPC_IOWCR2   (PA_MRSHPC + 26)
> #define MRSHPC_CDCR     (PA_MRSHPC + 28)
> #define MRSHPC_PCIC_INFO (PA_MRSHPC + 30)

There symbols are for PCMCIA controller .
SE7727 has Marubun PCMCIA controller(MR-SHPC-01).
> 
> #define PA_FPGA		0xB7000000 	/* FPGA base address */
> 
> #define MRSHPC_IRQ0    	14
> 
> #define FPGA_ILSR1	(PA_FPGA + 0x02)
> #define FPGA_ILSR2	(PA_FPGA + 0x03)
> #define FPGA_ILSR3	(PA_FPGA + 0x04)
> #define FPGA_ILSR4	(PA_FPGA + 0x05)
> #define FPGA_ILSR5	(PA_FPGA + 0x06)
> #define FPGA_ILSR6	(PA_FPGA + 0x07)
> #define FPGA_ILSR7	(PA_FPGA + 0x08)
> #define FPGA_ILSR8	(PA_FPGA + 0x09)
>  
> 	b. We don’t know how to define these sysbols.
SE7727 has Interrput controller on FPGA.
These symbols are written in the manual. 

I think that You may not worry about these, maybe.

Best regards,
 Nobuhiro
-- 
Nobuhiro Iwamatsu
