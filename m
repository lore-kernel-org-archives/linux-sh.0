From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 08:24:04 +0000
Subject: Re: Is it possible usign QEMU for runnung kernel of sh2a?
Message-Id: <aec7e5c31003190124m6831c029lc492de2777760727@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003190627.44881.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003190627.44881.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

On Fri, Mar 19, 2010 at 2:27 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Hi, could you tell me please how to find info about using qemu for sh2a if it
> is possible?

QEMU did not support sh2a last time I checked. And I doubt that anyone
added it recently.

It may however be a good idea to use QEMU to learn about initramfs and
user space programs on a different processor or architecture.

If I were you then I'd try to get QEMU working with x86 as target.
When you have initramfs working on x86 in QEMU then you can easily
move over to some other target. With sh2a on real hardware with an old
kernel version there are too many unknowns to make efficient progress.

Cheers,

/ magnus
