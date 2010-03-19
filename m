From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 05:44:32 +0000
Subject: Re: Trouble with embedding initial root fs into the kernel
Message-Id: <aec7e5c31003182244k1052e70bv60b692d20ab017c7@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 19, 2010 at 2:23 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Ok I understand.
> But now I'd like to test first as init the hello world program.
> Do you use uclibc for userspace building applications?

Nope, I've only used glibc on SH. Actually, I have very little
experience with sh2a user space, so you should ask someone else for
recommendation in that area.

You can always write a freestanding hello world example without libc:

http://blog.ksplice.com/2010/03/libc-free-world/

Cheers,

/ magnus
