From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 23 Mar 2009 03:49:37 +0000
Subject: Re: Kernel fails on Dreamcast - results of bisection
Message-Id: <aec7e5c30903222049l129c452bs33ce326f99bc25c9@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1237675045.27611.23.camel@localhost.localdomain>
In-Reply-To: <1237675045.27611.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Sun, Mar 22, 2009 at 7:37 AM, Adrian McMenamin
<adrian@newgolddream.dyndns.info> wrote:
> This is the result of the bisection. I cannot see what bit of this patch
> is causing the difficulties but I'm pretty sure that this is where it
> is. The actual problem is a race condition, as it does not happen on
> every boot...
>
> adrian@bossclass:~/lethal-repo$ git bisect good
> 955c0778723501cc16fec40501cd54b7e72d3e74 is first bad commit
> commit 955c0778723501cc16fec40501cd54b7e72d3e74
> Author: Magnus Damm <damm@igel.co.jp>
> Date: =A0 Thu Jan 22 09:55:31 2009 +0000
>
> =A0 =A0sh: rework clocksource and sched_clock
>
> =A0 =A0Rework and simplify the sched_clock and clocksource code. Instead
> =A0 =A0of registering the clocksource in a shared file we move it into the
> =A0 =A0tmu driver. Also, add code to handle sched_clock in the case of no
> =A0 =A0clocksource.
>
> =A0 =A0Signed-off-by: Magnus Damm <damm@igel.co.jp>
> =A0 =A0Signed-off-by: Paul Mundt <lethal@linux-sh.org>

Unless you have some dreamcast specific timer dependencies I really
doubt that this patch is the cause of your problems. How about
creating a smaller kernel? Take the defconfig and remove for instance
cpufreq, mtd and all filesystems except whatever your rootfs is on.

Cheers,

/ magnus
