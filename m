From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Oct 2011 08:24:23 +0000
Subject: Re: [PATCH v2] sh: Take into account the base of System RAM in virt_to_phys()
Message-Id: <CANqRtoT1ik9x+s10K6dBy34pDv5+up9dCweVF5MOctWeB=gxAw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1317603918-30762-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1317603918-30762-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Oct 3, 2011 at 10:05 AM, Simon Horman <horms@verge.net.au> wrote:
> Previously virt_to_phys() assumed that physical memory always started
> at address 0. This is not always the case.
>
> Tested on an sh7757lcr (32bit system) whose only System RAM region is
> 40000000-4effffff and an ecovec24 (29bit system).
>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> ---
> =A0kexec/arch/sh/kexec-sh.c | =A0 45 ++++++++++++++++++++++++++++++++++++=
++++++++-
> =A01 files changed, 44 insertions(+), 1 deletions(-)
>
> v2
> * Only use the base of System RAM as an offset into physical memory
> =A0if 32bit addressing is in use.

This version looks much better, thanks!

/ magnus
