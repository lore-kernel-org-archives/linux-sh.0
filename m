From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 26 Aug 2009 08:02:06 +0000
Subject: Re: Current ms7724se LAN doesn't work
Message-Id: <aec7e5c30908260102u774de61aydc3c349423a50181@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 24, 2009 at 6:55 PM, Paul Mundt<lethal@linux-sh.org> wrote:
> On Mon, Aug 24, 2009 at 06:45:45PM +0900, Kuninori Morimoto wrote:
>>
>> Dear Paul
>>
>> Thank you for your patch
>>
>> > This would be a runtime PM issue, which SH-Mobile unconditionally
>> > selects. The problem is that the module is most likely disabled via its
>> > MSTP bit under the new scheme, so sh-eth will need to tie in to the
>> > runtime PM framework to get that resolved.
>> >
>> > Can you give this a try?
>>
>> hmmm..
>> I tried this patch, but it still doesn't work.
>> log is
>>
> Ok, we'll have to let Magnus take a look at it then, as it's certainly
> runtime PM related.

It looks like the driver is accessing hardware from probe, so you need
to force a resume after enable. The LCDC driver does just that:

       pm_runtime_enable(priv->dev);
       pm_runtime_resume(priv->dev);

Hopefully that should do the trick. Can you try this fix on top of
Paul's patch Morimoto-san?

Cheers,

/ magnus
