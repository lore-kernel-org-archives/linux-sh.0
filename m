From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 20 Feb 2015 19:21:56 +0000
Subject: Re: [PATCH] x86/vdso: Remove all generated files during clean
Message-Id: <54E78954.5070802@amacapital.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20150219021311.24366.75477.sendpatchset@little-apple>
In-Reply-To: <20150219021311.24366.75477.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, luto@amacapital.net
Cc: linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de

On 02/18/2015 06:13 PM, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Make sure the following files are removed as expected during "make clean":
>   + arch/x86/vdso/vdso-image-32-int80.c
>   + arch/x86/vdso/vdso-image-32-syscall.c
>   + arch/x86/vdso/vdso-image-32-sysenter.c
>   + arch/x86/vdso/vdso-image-64.c
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>   arch/x86/vdso/Makefile |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- 0001/arch/x86/vdso/Makefile
> +++ work/arch/x86/vdso/Makefile	2015-02-19 10:50:15.975470639 +0900
> @@ -1,3 +1,4 @@
> +
>   #
>   # Building vDSO images for x86.
>   #
> @@ -206,4 +207,5 @@ $(vdso_img_insttargets): install_%: $(ob
>   PHONY += vdso_install $(vdso_img_insttargets)
>   vdso_install: $(vdso_img_insttargets) FORCE
>
> -clean-files := vdso32-syscall* vdso32-sysenter* vdso32-int80* vdso64*
> +clean-files := vdso32-syscall* vdso32-sysenter* vdso32-int80* vdso64* \
> +               vdso-image-32* vdso-image-64*
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Applied, sans the extra newline.

Thanks,
Andy
