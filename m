From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Sep 2014 04:17:54 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Cleanup PM Kconfig usage
Message-Id: <CANqRtoTdb=_fmiuk2nxXKz8q6+qYxHb1S_OvmC416k9OG7WCiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904033942.22881.84361.sendpatchset@w520>
In-Reply-To: <20140904033942.22881.84361.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thu, Sep 4, 2014 at 1:12 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Sep 04, 2014 at 12:39:42PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Simplify the r8a7740 PM code by using CONFIG_PM_RMOBILE instead
>> of having a complex #if expression embedded in the C code.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> Thanks Magnus,
>
> this looks good to me.
>
> The dependencies for this changes are a bit messy so I would like
> to defer it until v3.19. Could you repost it once v3.18-rc6 is released?

Sure, will do! Does that apply to this patch only, or also to other
things like the new (sh73a0 and/or r8a73a4) multiplatform bits and
legacy board code removal?

Thanks,

/ magnus
