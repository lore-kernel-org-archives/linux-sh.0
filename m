From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 23 May 2014 11:45:17 +0000
Subject: Re: R-CAR's arch
Message-Id: <20140523134517.7ed2eae1@endymion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <20140522101938.51fec16f@endymion.delvare>
In-Reply-To: <20140522101938.51fec16f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Fri, 23 May 2014 15:31:43 +0400, Sergei Shtylyov wrote:
> On 05/23/2014 12:23 PM, Jean Delvare wrote:
> > This is an interesting approach, I like it. I'll stick to it for my
> > future patches, starting with CONFIG_USB_RCAR_PHY and
> > CONFIG_VIDEO_RCAR_VIN.
> 
> > For USB PHY the dependencies are clear.
> 
>     Do you mean ARCH_MOBILE || COMPILE_TEST? Actually, looking at generation 2 
> PHY entry, ARCH_R8A7778 || ARCH_R8A7779 probably makes more sense.

So I got it right :)

http://marc.info/?l=linux-usb&m0083419507463&w=2

> > For VIN I'm not so sure, does
> > anybody know? I'd got for ARCH_SHMOBILE || COMPILE_TEST but I don't know
> > if SUPERH should be listed too.
> 
>     TTBOMK, no. VIN has been first encountered on ARCH_SMOBILE.

OK, thanks.

-- 
Jean Delvare
SUSE L3 Support
