From: Peter Hurley <peter@hurleysoftware.com>
Date: Wed, 11 Mar 2015 13:42:41 +0000
Subject: Re: chosen/stdout-path and userland (Re: Can't boot kernel v4.0-rc2 on Koelsch)
Message-Id: <55004651.2000205@hurleysoftware.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVSbYYGQyOjce87Q_dMHvh9du1EkgOgC+CBgrMys++mkA@mail.gmail.com>	<55003D82.1080601@hurleysoftware.com> <CAMuHMdWjHnX4NS2Z7MMg9FBjDpo41h517U3t+ndSCzhGKDLCvA@mail.gmail.com>
In-Reply-To: <CAMuHMdWjHnX4NS2Z7MMg9FBjDpo41h517U3t+ndSCzhGKDLCvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Sakato Ryusuke <ryusuke.sakato.bx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Geert,

On 03/11/2015 09:23 AM, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Wed, Mar 11, 2015 at 2:05 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> The first console listed is the primary console.
>> tty0 is not resolved to its underlying tty device name.
> 
> Are you sure about that? Isn't the last one the primary console?
> 
> root@koelsch:~# cat  /sys/class/tty/console/active
> tty0 ttySC0
> 
> If tty0 would be the primary console, getty on /dev/console wouldn't work for
> my serial console, as only input on the primary console can be read through
> /dev/console if my memory serves me well (or perhaps this has changed?).
> 
> Ah, Documentation/ABI/testing/sysfs-tty agrees with me:
> 
> What:           /sys/class/tty/console/active
> Date:           Nov 2010
> Contact:        Kay Sievers <kay.sievers@vrfy.org>
> Description:
>                  Shows the list of currently configured
>                  console devices, like 'tty1 ttyS0'.
>                  The last entry in the file is the active
>                  device connected to /dev/console.

Did I write 'first'?  <blushes>
Yeah, it is 'last', as the documentation states.

>> That said, is the original reporter of this problem even interested in
>> upgrading their userspace, even if this is fixed in Linaro eventually?
>> What about other Linaro users?
> 
> We'll see...
> 
>> I think the only reasonable course here is to continue to support
>> "console=" in /chosen/bootargs.
> 
> Hmm...
> If you really need it, you can always add it to the U-Boot bootargs variable.

Is u-boot a given?

Regards,
Peter Hurley
