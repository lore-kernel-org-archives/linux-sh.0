From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 16:26:27 +0000
Subject: Re: [PATCH 00/03] dmaengine: shdma: sh73a0 and SH_DMAC_MAX_CHANNELS
Message-Id: <BANLkTikTAxn=2HK7EFXQb_VkW8whds-R-Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110524103104.10334.42987.sendpatchset@t400s>
In-Reply-To: <20110524103104.10334.42987.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, May 25, 2011 at 12:43 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, May 24, 2011 at 07:31:04PM +0900, Magnus Damm wrote:
>> dmaengine: shdma: sh73a0 and SH_DMAC_MAX_CHANNELS
>>
>> [PATCH 01/03] dmaengine: shdma: Make second memory window optional
>> [PATCH 02/03] dmaengine: shdma: Fix SH_DMAC_MAX_CHANNELS handling
>> [PATCH 03/03] dmaengine: shdma: Update SH_DMAC_MAX_CHANNELS to 20
>>
>> These patches update the shdma dmaengine driver to support DMA
>> controllers with more than 6 slave-id capable channels mapped
>> into a single I/O-memory window. While at it fix the handling
>> of SH_DMAC_MAX_CHANNELS that without [PATCH 02/03] may overflow
>> some arrays at probe() time depending on platform data.
>>
>> Needed to support the 20-channel SY-DMAC block included in sh73a0.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>> =A0Since these patches are only touching the shdma driver perhaps
>> =A0merging through the sh-2.6 tree is the easiest?
>>
> Easiest perhaps, but as the merge window is closing on Sunday and I've
> already sent the sh bits off, none of this is likely to make it for -rc1.
>
> I'm also not very thrilled about the amount of churn that the rmobile
> bits add on top of this with regards to -rc2 timing, and with -rc1 timing
> there's basically zero time for -next coverage should I slam all of it in
> to the rmobile tree -- none of these options are terribly appealing. This
> all should have been posted weeks ago.

The patches in this series that modify shdma.c and shdma.h are quite
trivial from my point of view, patch 1 is the most advanced one and I
don't think any exposure in -next would help. I would say it's highly
unlikely to break any existing platform, and I doubt that any
platforms that may break actually get tested in -next. Also, the
patches do not depend on any special kernel configuration option, so
all the code in this series will unconditionally be compiled if the
shdma driver is enabled. So little risk of compile issues. Patch 2 is
a fix and should be applied sooner than later IMO, and 3 is just a one
liner.

I do however agree that this series should have been posted weeks ago,
but I was unfortunately not aware of these issues at that point.

And then we have the sh73a0 DMAC platform data which has a run time
dependency on this series.

Thanks,

/ magnus
