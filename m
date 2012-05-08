From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 May 2012 16:34:47 +0000
Subject: Re: [PATCH 00/06] serial8250: DLL/DLM rework, Emma Mobile UART driver
Message-Id: <CANqRtoSypEnwgYM+VDL1rn_XvrKCpuKbhDMRkj=c2WSJE38Thw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120502124642.30480.41373.sendpatchset@w520>
	<201205041628.20024.arnd@arndb.de>
In-Reply-To: <201205041628.20024.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, horms@verge.net.au, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, paul.gortmaker@windriver.com, lethal@linux-sh.org, olof@lixom.net, dan.j.williams@intel.com, alan@linux.intel.com

On Sat, May 5, 2012 at 1:28 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 02 May 2012, Magnus Damm wrote:
>> Note that there is no DT support included at this point,
>> but it boils down to a 10 line change. The boot loader on
>> my board does not do DT so I'd like to use kexec for DT
>> development (as usual), but to use kexec I first need to
>> get a non-DT kernel working. Which is basically this. =)
>
> As a follow-up on this, based on my comments to your emma platform
> code, I think it would be easy enough to just use the appended
> dtb support that we have, which allows you to boot a DT-enabled
> kernel with a legacy boot loader.

Thanks for your comments! I have some code going with DT now. Will
post tomorrow.

As for the appended dtb support, do you know the recommended way to
include it in the uImage? It feels a bit odd to recommend customers to
patch their kernel source to build a bootable kernel.  I ended up with
this local hackery, but there must be better ways:

--- 0001/arch/arm/boot/Makefile
+++ work/arch/arm/boot/Makefile 2012-05-09 00:40:17.000000000 +0900
@@ -53,6 +53,7 @@ $(obj)/compressed/vmlinux: $(obj)/Image

 $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
        $(call if_changed,objcopy)
+       cat $(obj)/emev2-kzm9d.dtb >> $@
        @echo '  Kernel: $@ is ready'

 endif

Cheers,

/ magnus
