From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2015 10:08:16 +0000
Subject: chosen/stdout-path and userland (Re: Can't boot kernel v4.0-rc2 on Koelsch)
Message-Id: <CAMuHMdVSbYYGQyOjce87Q_dMHvh9du1EkgOgC+CBgrMys++mkA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: Cao Minh Hiep <cm-hiep@jinso.co.jp>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Sakato Ryusuke <ryusuke.sakato.bx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

TL;DR

After removing the "console=" parameter from chosen/bootargs, and relying
solely on chosen/stdout-path, Hiep-san's Linaro userland cannot find the
console device anymore.

On Wed, Mar 11, 2015 at 7:45 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 10 March 2015 12:32:59 Geert Uytterhoeven wrote:
>> On Tue, Mar 10, 2015 at 10:03 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
>> > On 2015年03月10日 17:05, Nobuhiro Iwamatsu wrote:
>> >> This is user land issue.
>> >> Hiep, if you have not changed ttySCX in inittab, you will need to change.
>> >> Could you check your inittab?
>> >>
>> >> --- a/inittab    2015-03-10 15:01:58.986609389 +0900
>> >> +++ b/inittab    2015-03-10 15:00:32.132094877 +0900
>> >> @@ -28,7 +28,7 @@
>> >>
>> >>   l6:6:wait:/etc/init.d/rc 6
>> >>   # Normally not reached, but fallthrough in case of emergency.
>> >>   z6:6:respawn:/sbin/sulogin
>> >>
>> >> -SC6:12345:respawn:/sbin/getty -L 38400 ttySC6
>> >> +SC0:12345:respawn:/sbin/getty -L 38400 ttySC0
>> >>
>> >>   # /sbin/getty invocations for the runlevels.
>> >>   #
>> >>   # The "id" field MUST be the same as the last
>> >
>> > There is no inittab file in Linaro userland that I am using.
>>
>> I'm not familiar with the Linaro userland.
>>
>> Is there any other configuration file that contains the string "ttySC6"?
>> Or does the Linaro userland derive it from the kernel command line?
>> If yes, perhaps there's a newer version that does look at stdout-path
>> instead?
>>
>> The goal of the stdout-path support was to have a better description in DT
>> and automate things. So I don't think reverting the change is the proper way
>> forward.
>>
>> If you can't get it to work, I think we should bring it up with the DT
>> people first, some of which work for Linaro.
>
> I quite agree with that, but how should userspace know which device node in
> /dev corresponds to the console specified in stdout-path ?

root@koelsch:~# hd /sys/firmware/devicetree/base/chosen/stdout-path
00000000  2f 73 65 72 69 61 6c 40  65 36 65 36 30 30 30 30  |/serial@e6e60000|
00000010  00                                                |.|
00000011
root@koelsch:~# ls -l /sys/devices/platform/e6e60000.serial/tty
total 0
drwxr-xr-x 3 root root 0 Mar 11 10:50 ttySC0
root@koelsch:~# cat /sys/devices/platform/e6e60000.serial/tty/ttySC0/dev
204:8
root@koelsch:~# ls -l /dev/ttySC0
crw------- 1 root tty 204, 8 Mar 11 10:46 /dev/ttySC0

Hence all pieces of the puzzle are available to userspace...
Is there another way?

BTW, we also had the "/dev/console" abstraction for quite a while.
I've just replaced "ttySC0" by "console" in my /etc/inittab, and everything
still works fine. That's Debian (without systemd) though, so it doesn't help
for the Linaro userland.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
