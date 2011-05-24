From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 08:47:27 +0000
Subject: Re: [PATCH 5/6] fbdev: sh_mobile_meram: Add clock enable/disble hooks
Message-Id: <BANLkTikP2OBM+enxQZFhVqBawFZT5QguYg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1305717011-20742-6-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1305717011-20742-6-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, May 24, 2011 at 12:04 PM, Damian Hobson-Garcia
<dhobsong@igel.co.jp> wrote:
> Hi Magnus,
>>> +int sh_mobile_meram_clk_on(struct sh_mobile_meram_info *pdata)
>>> +{
>>> + =A0 =A0 =A0 if (!pdata || !pdata->pdev)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> +
>>> + =A0 =A0 =A0 dev_dbg(&pdata->pdev->dev, "Enabling sh_mobile_meram cloc=
k.");
>>> + =A0 =A0 =A0 pm_runtime_get(&pdata->pdev->dev);
>>
>> This should be pm_runtime_get_sync() to force block until the clock is e=
nabled.
> Not a problem. I'll update that.
>>
>>> diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_=
meram.h
>>> index af602d6..3605874 100644
>>> --- a/include/video/sh_mobile_meram.h
>>> +++ b/include/video/sh_mobile_meram.h
>>> @@ -63,6 +63,12 @@ struct sh_mobile_meram_ops {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long ba=
se_addr_c,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long *i=
cb_addr_y,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long *i=
cb_addr_c);
>>> +
>>> + =A0 =A0 =A0 /* enable meram clock */
>>> + =A0 =A0 =A0 int (*meram_clk_on)(struct sh_mobile_meram_info *meram_de=
v);
>>> +
>>> + =A0 =A0 =A0 /* disable meram clock */
>>> + =A0 =A0 =A0 int (*meram_clk_off)(struct sh_mobile_meram_info *meram_d=
ev);
>>
>> Hm, we need more than just clock control. Runtime PM is used for both
>> clock and power domain control. This means that after pm_runtime_put()
>> the power to the MERAM may be turned off. So you probably want to add
>> some context save/restore code to make sure the MERAM settings are
>> re-initialized after power-up. At this point there are no patches
>> upstream for this, but I think we should give it a try after
>> 2.6.40-rc1 or rc2 is out.
>>
> WRT the context save/restore, I'm thinking that unlike the clock
> enable/disable, which is tied into the LCDC driver clocks, the context
> save/restore should be implemented via the ->runtime_suspend(),
> ->runtime_restore() callbacks, tied into the power domain (which is this
> case is actually the same as LCDC A4LC). If that makes sense I'll submit
> a patch to that effect along with the above.

So the context save/restore needs to happen from the MERAM driver
callbacks. But with Runtime PM they may only be executed in the "idle"
state (after put()) and if I've understood these patches correctly you
use pm_runtime_get_sync() in the meram_clk_on/off() callbacks. My
point is that the callbacks are named "meram_clk_on/off" but you
actually control more than the clock state.

Let's revisit all this after Linuxcon Japan and 2.6.40-rcN is out.

Thanks,

/ magnus
