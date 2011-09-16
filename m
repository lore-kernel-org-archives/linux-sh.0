From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 16 Sep 2011 10:59:21 +0000
Subject: Re: [RFC] sh: Take into account the base of physical memory in virt_to_phys()
Message-Id: <CANqRtoSa-Bk-QAdfzHQra8WTe93Qp=yMMm5Z81zYnHo7t158Bw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1316085179-4207-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1316085179-4207-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Sep 15, 2011 at 8:12 PM, Simon Horman <horms@verge.net.au> wrote:
> Previously virt_to_phys() assumed that physical memory always started
> at address 0. This is not always the case.

I think most boards have NOR Flash or ROM mapped at physical address 0.

For more information please have a look at: arch/sh/boards/mach-ecovec24/se=
tup.c

> --- a/kexec/arch/sh/kexec-sh.c
> +++ b/kexec/arch/sh/kexec-sh.c
> @@ -188,10 +188,18 @@ void kexec_sh_setup_zero_page(char *zero_page_buf, =
size_t zero_page_size,
> =A0unsigned long virt_to_phys(unsigned long addr)
> =A0{
> =A0 =A0 =A0 =A0unsigned long seg =3D addr & 0xe0000000;
> + =A0 =A0 =A0 unsigned long long start, end;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 /* Assume there is only one "System RAM" region */
> + =A0 =A0 =A0 ret =3D parse_iomem_single("System RAM\n", &start, &end);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Could not parse System RAM region in /=
proc/iomem\n");
> +
> =A0 =A0 =A0 =A0if (seg !=3D 0x80000000 && seg !=3D 0xc0000000)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Virtual address %p is not in P1 or P2=
\n", (void *)addr);
>
> - =A0 =A0 =A0 return addr - seg;
> + =A0 =A0 =A0 return addr - seg + start;
> =A0}

This will most likely also change how 29-bit platforms translate their
addresses, not sure if that's what you want to do.

Thanks,

/ magnus
