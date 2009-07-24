From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 24 Jul 2009 03:30:06 +0000
Subject: Re: Problem with current kernel and old sh3 machines
Message-Id: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Rafael,

On Sat, Jun 27, 2009 at 3:46 AM, Rafael Ignacio
Zurita<rizurita@yahoo.com> wrote:
> Hello,
>
> On Thu, Jun 25, 2009 at 11:12:20AM +0900, Paul Mundt wrote:
>> On Wed, Jun 24, 2009 at 08:48:50PM -0300, Rafael Ignacio Zurita wrote:
>> > =A0 Current linus linux-2.6 git kernel does not boot in two
>> > old Sh3 machines: Hp Palmtop 660lx and HP Jornada 680.
>> >
>> > After git bisect for a while it finds the problematic commit
>> > below for the ancient machines:
>> >
>> > commit f19900b2e608b604777a74d6d711bbf744657756
>> > ...
>> >
>> > There is not serial output at all when I try to boot.
>> > I have also selected the sh_tmu driver with CONFIG_SH_TIMER_TMU
>> > in .config.
>> >
>> > Can I try something more? like another option in .config?
>> >
>> Well, it does of course boot, but it is possible that you are crashing
>> somewhere in the early initialization before the serial driver comes up.
>> What you may wish to do is comment out the early platform tmu
>> registration in your setup-shxxx.c file for your CPU and use the old TMU
>> driver for the system timer. This should at least get you past serial
>> init. Barring that, you really need to get early printk going.
>
> On Fri, Jun 26, 2009 at 04:54:39PM +0900, Magnus Damm wrote:
>>
>> Like Paul mentioned, you really need early printk to debug this. If
>> you have time to spend on this let me know and I'll try to direct you
>> so we can track this down.
>
> =A0thanks for the answers.
>
> I tried to comment out the platform tmu registration and use
> the old TMU driver. It was a bit messy, but I managed to build
> and test. No luck. Of course, it can be something that I did wrong.
>
> Anyway, I would like to get early printk, to debug the problem.
> It looks promising :-)
>
> Magnus, I have time to spend on this. Also, I have just started to read
> about early printk, so if you can help me, I am all ears, and
> I will try to do my best.

Sorry about the delay. If you still have time, please let me know
which hardware platform you want to focus on.

Cheers,

/ magnus
