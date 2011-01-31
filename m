From: "Fabio Giovagnini" <fabio.giovagnini@aurion-tech.com>
Date: Mon, 31 Jan 2011 10:22:57 +0000
Subject: Re: sh-2.6 v2.6.37 and rsk+7203 framebuffer management
Message-Id: <393e9fbcb0e185177716e982773f6ac1.squirrel@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101310645.09489.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101310645.09489.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is exactly what I was to clirify.

Thanks


> Hi Fabio,
>
> On Mon, Jan 31, 2011 at 3:28 PM, Fabio Giovagnini
> <fabio.giovagnini@aurion-tech.com> wrote:
>> Hi guys,
>> I have given a look at the hm of sh4 7760 and sh2a 7203.
>> It seems that the LCDC is the same, lass the addresses of the register.
>> I suppose I derive the driver from sh7760fb.c / sh7760fb.h
>>
>> But, do I have to assume tha it is not possible to use as is the
>> sh_mobile_lcdc modules?
>
> The driver sh_mobile_lcdcfb is designed to work with the LCDC block
> commonly found in the SH Mobile family of SoCs - including sh7722,
> sh7723, sh7724, sh7343, sh7366, sh7367, sh7377, sh7372 and sh73a0.
>
> sh7302 and sh7760 are not part of the SH Mobile family and are not
> supported by the "sh_mobile_lcdcdfb" driver.
>
> Hope this clarifies,
>
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


