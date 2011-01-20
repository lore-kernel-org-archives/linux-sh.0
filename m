From: "Fabio Giovagnini" <fabio.giovagnini@aurion-tech.com>
Date: Thu, 20 Jan 2011 08:43:52 +0000
Subject: Re: linux 2.6.37+ seems to go to sleep
Message-Id: <18f7c5e47ea265ab6ac49a1702a7381f.squirrel@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks Magnus,
I suppposed to be wrong.

I'll try and I'll keep yuo informed

Best Regards

P.S.
Can I be sure the BRR setting algorithm used is proper for my sh2a 7203?
Do you know if anyone tested teh last linux version on rsk+ 7203?

Thanks a lot




> Hi Fabio,
>
> On Thu, Jan 20, 2011 at 3:26 PM, Fabio Giovagnini
> <fabio.giovagnini@aurion-tech.com> wrote:
>> Hi Magnus,
>> could you write to me please the exact cmdline to put in boot option and
>> / or
>> bootargs env variable of u-boot?
>
> You know, you can always grep the default kernel configurations:
>
> For the rsk7302 board try this:
>
> $ grep CONFIG_CMDLINE arch/sh/configs/rsk7203_defconfig
> CONFIG_CMDLINE_OVERWRITE=y
> CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=serial ignore_loglevel"
> $
>
> The earlyprintk format seems a bit outdated though - it unfortunately
> looks like too few people are submitting rsk7302 patches upstream.
>
> Try using this kernel command line:
> CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=sh-sci.0,115200
> ignore_loglevel"
>
> You can also look at this commit for more information about
> earlyprintk and sh-sci:
> $ git log 7b6fd3bf82c4901f6ba0101ba71a5c507c24f9cf
>
> / magnus
>


