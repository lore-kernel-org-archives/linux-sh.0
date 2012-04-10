From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Apr 2012 08:27:56 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <87ty0skn3r.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for checking patch

> unfortunately I seem to be having a lot of trouble reliably booting using
> these patches. I am using tftpboot as follows:
> 
> hermit>  tftpboot 10.3.3.147 10.3.3.135 --kernel=armadillo/uImage

I'm using Image file here, not uImage.

# you can use "setbootdevice" here for tftpboot.
# then you can just run "b"
http://manual.atmark-techno.com/armadillo-4x0/armadillo-400_series_software_manual_ja-1.2.0/apa.html#sec-setbootdevice

> Sometimes the kernel boots bot mostly it doesn't.

Similar things happened on v3.3 kernel.
I thought v3.4-rcX seems work well, but...

What's happen if you use "cold-boot" ?

> Are you also using tftpboot?

Yes. I'm using tftpboot.

> Also, could you let me know which compiler you are using?

I'm using this

# arm-none-linux-gnueabi-gcc --version
arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2010q1-202) 4.4.1
Copyright (C) 2009 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


Best regards
---
Kuninori Morimoto
