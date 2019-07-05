From: Dave Young <dyoung@redhat.com>
Date: Fri, 05 Jul 2019 05:55:40 +0000
Subject: Re: [PATCH 18/39] docs: admin-guide: add kdump documentation into it
Message-Id: <20190705055540.GA2790@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <654e7591c044632c06257e0f069a52c0bb993554.1561724493.git.mchehab+samsung@kernel.org>
In-Reply-To: <654e7591c044632c06257e0f069a52c0bb993554.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, Harry Wei <harryxiyou@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Alex Shi <alex.shi@linux.alibaba.com>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org

On 06/28/19 at 09:30am, Mauro Carvalho Chehab wrote:
> The Kdump documentation describes procedures with admins use
> in order to solve issues on their systems.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/admin-guide/bug-hunting.rst            | 4 ++--
>  Documentation/admin-guide/index.rst                  | 1 +
>  Documentation/{ => admin-guide}/kdump/gdbmacros.txt  | 0
>  Documentation/{ => admin-guide}/kdump/index.rst      | 1 -
>  Documentation/{ => admin-guide}/kdump/kdump.rst      | 0
>  Documentation/{ => admin-guide}/kdump/vmcoreinfo.rst | 0
>  Documentation/admin-guide/kernel-parameters.txt      | 6 +++---
>  Documentation/powerpc/firmware-assisted-dump.rst     | 2 +-
>  Documentation/translations/zh_CN/oops-tracing.txt    | 4 ++--
>  Documentation/watchdog/hpwdt.rst                     | 2 +-
>  MAINTAINERS                                          | 2 +-
>  arch/arm/Kconfig                                     | 2 +-
>  arch/arm64/Kconfig                                   | 2 +-
>  arch/sh/Kconfig                                      | 2 +-
>  arch/x86/Kconfig                                     | 4 ++--
>  15 files changed, 16 insertions(+), 16 deletions(-)
>  rename Documentation/{ => admin-guide}/kdump/gdbmacros.txt (100%)
>  rename Documentation/{ => admin-guide}/kdump/index.rst (97%)
>  rename Documentation/{ => admin-guide}/kdump/kdump.rst (100%)
>  rename Documentation/{ => admin-guide}/kdump/vmcoreinfo.rst (100%)
> 
> diff --git a/Documentation/admin-guide/bug-hunting.rst b/Documentation/admin-guide/bug-hunting.rst
> index b761aa2a51d2..44b8a4edd348 100644
> --- a/Documentation/admin-guide/bug-hunting.rst
> +++ b/Documentation/admin-guide/bug-hunting.rst
> @@ -90,9 +90,9 @@ the disk is not available then you have three options:
>      run a null modem to a second machine and capture the output there
>      using your favourite communication program.  Minicom works well.
>  
> -(3) Use Kdump (see Documentation/kdump/kdump.rst),
> +(3) Use Kdump (see Documentation/admin-guide/kdump/kdump.rst),
>      extract the kernel ring buffer from old memory with using dmesg
> -    gdbmacro in Documentation/kdump/gdbmacros.txt.
> +    gdbmacro in Documentation/admin-guide/kdump/gdbmacros.txt.
>  
>  Finding the bug's location
>  --------------------------
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 9899b78dbe50..65e821a03aca 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -39,6 +39,7 @@ problems and bugs in particular.
>     ramoops
>     dynamic-debug-howto
>     init
> +   kdump/index
>     perf/index
>  
>  This is the beginning of a section with information of interest to
> diff --git a/Documentation/kdump/gdbmacros.txt b/Documentation/admin-guide/kdump/gdbmacros.txt
> similarity index 100%
> rename from Documentation/kdump/gdbmacros.txt
> rename to Documentation/admin-guide/kdump/gdbmacros.txt
> diff --git a/Documentation/kdump/index.rst b/Documentation/admin-guide/kdump/index.rst
> similarity index 97%
> rename from Documentation/kdump/index.rst
> rename to Documentation/admin-guide/kdump/index.rst
> index 2b17fcf6867a..8e2ebd0383cd 100644
> --- a/Documentation/kdump/index.rst
> +++ b/Documentation/admin-guide/kdump/index.rst
> @@ -1,4 +1,3 @@
> -:orphan:
>  
>  ================================
>  Documentation for Kdump - The kexec-based Crash Dumping Solution
> diff --git a/Documentation/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> similarity index 100%
> rename from Documentation/kdump/kdump.rst
> rename to Documentation/admin-guide/kdump/kdump.rst
> diff --git a/Documentation/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> similarity index 100%
> rename from Documentation/kdump/vmcoreinfo.rst
> rename to Documentation/admin-guide/kdump/vmcoreinfo.rst
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e38b96d061f4..9b535c0e22f3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -708,14 +708,14 @@
>  			[KNL, x86_64] select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
> -			See Documentation/kdump/kdump.rst for further details.
> +			See Documentation/admin-guide/kdump/kdump.rst for further details.
>  
>  	crashkernel=range1:size1[,range2:size2,...][@offset]
>  			[KNL] Same as above, but depends on the memory
>  			in the running system. The syntax of range is
>  			start-[end] where start and end are both
>  			a memory unit (amount[KMG]). See also
> -			Documentation/kdump/kdump.rst for an example.
> +			Documentation/admin-guide/kdump/kdump.rst for an example.
>  
>  	crashkernel=size[KMG],high
>  			[KNL, x86_64] range could be above 4G. Allow kernel
> @@ -1207,7 +1207,7 @@
>  			Specifies physical address of start of kernel core
>  			image elf header and optionally the size. Generally
>  			kexec loader will pass this option to capture kernel.
> -			See Documentation/kdump/kdump.rst for details.
> +			See Documentation/admin-guide/kdump/kdump.rst for details.
>  
>  	enable_mtrr_cleanup [X86]
>  			The kernel tries to adjust MTRR layout from continuous
> diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
> index d7fa7c35dd12..9ca12830a48e 100644
> --- a/Documentation/powerpc/firmware-assisted-dump.rst
> +++ b/Documentation/powerpc/firmware-assisted-dump.rst
> @@ -61,7 +61,7 @@ as follows:
>           the default calculated size. Use this option if default
>           boot memory size is not sufficient for second kernel to
>           boot successfully. For syntax of crashkernel= parameter,
> -         refer to Documentation/kdump/kdump.rst. If any offset is
> +         refer to Documentation/admin-guide/kdump/kdump.rst. If any offset is
>           provided in crashkernel= parameter, it will be ignored
>           as fadump uses a predefined offset to reserve memory
>           for boot memory dump preservation in case of a crash.
> diff --git a/Documentation/translations/zh_CN/oops-tracing.txt b/Documentation/translations/zh_CN/oops-tracing.txt
> index 368ddd05b304..c5f3bda7abcb 100644
> --- a/Documentation/translations/zh_CN/oops-tracing.txt
> +++ b/Documentation/translations/zh_CN/oops-tracing.txt
> @@ -53,8 +53,8 @@ cat /proc/kmsg > file， 然而你必须介入中止传输， kmsg是一个“
>  （2）用串口终端启动（请参看Documentation/admin-guide/serial-console.rst），运行一个null
>  modem到另一台机器并用你喜欢的通讯工具获取输出。Minicom工作地很好。
>  
> -（3）使用Kdump（请参看Documentation/kdump/kdump.rst），
> -使用在Documentation/kdump/gdbmacros.txt中定义的dmesg gdb宏，从旧的内存中提取内核
> +（3）使用Kdump（请参看Documentation/admin-guide/kdump/kdump.rst），
> +使用在Documentation/admin-guide/kdump/gdbmacros.txt中定义的dmesg gdb宏，从旧的内存中提取内核
>  环形缓冲区。
>  
>  完整信息
> diff --git a/Documentation/watchdog/hpwdt.rst b/Documentation/watchdog/hpwdt.rst
> index 94a96371113e..49c647dba8aa 100644
> --- a/Documentation/watchdog/hpwdt.rst
> +++ b/Documentation/watchdog/hpwdt.rst
> @@ -59,7 +59,7 @@ Last reviewed: 08/20/2018
>   and loop forever.  This is generally not what a watchdog user wants.
>  
>   For those wishing to learn more please see:
> -	Documentation/kdump/kdump.rst
> +	Documentation/admin-guide/kdump/kdump.rst
>  	Documentation/admin-guide/kernel-parameters.txt (panic=)
>  	Your Linux Distribution specific documentation.
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d35ff73f718a..4c622a19ab7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8622,7 +8622,7 @@ R:	Vivek Goyal <vgoyal@redhat.com>
>  L:	kexec@lists.infradead.org
>  W:	http://lse.sourceforge.net/kdump/
>  S:	Maintained
> -F:	Documentation/kdump/
> +F:	Documentation/admin-guide/kdump/
>  
>  KEENE FM RADIO TRANSMITTER DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 8bf8985ec667..d5bd4350fcbd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2025,7 +2025,7 @@ config CRASH_DUMP
>  	  kdump/kexec. The crash dump kernel must be compiled to a
>  	  memory address not used by the main kernel
>  
> -	  For more details see Documentation/kdump/kdump.rst
> +	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
>  config AUTO_ZRELADDR
>  	bool "Auto calculation of the decompressed kernel image address"
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index accb045997c6..e1ea69994e0f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -997,7 +997,7 @@ config CRASH_DUMP
>  	  reserved region and then later executed after a crash by
>  	  kdump/kexec.
>  
> -	  For more details see Documentation/kdump/kdump.rst
> +	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
>  config XEN_DOM0
>  	def_bool y
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 31a7d12db705..c2858ac6a46a 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -626,7 +626,7 @@ config CRASH_DUMP
>  	  to a memory address not used by the main kernel using
>  	  PHYSICAL_START.
>  
> -	  For more details see Documentation/kdump/kdump.rst
> +	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
>  config KEXEC_JUMP
>  	bool "kexec jump (EXPERIMENTAL)"
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c9d59ca5e3ac..489fd833b980 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2057,7 +2057,7 @@ config CRASH_DUMP
>  	  to a memory address not used by the main kernel or BIOS using
>  	  PHYSICAL_START, or it must be built as a relocatable image
>  	  (CONFIG_RELOCATABLE=y).
> -	  For more details see Documentation/kdump/kdump.rst
> +	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
>  config KEXEC_JUMP
>  	bool "kexec jump"
> @@ -2094,7 +2094,7 @@ config PHYSICAL_START
>  	  the reserved region.  In other words, it can be set based on
>  	  the "X" value as specified in the "crashkernel=YM@XM"
>  	  command line boot parameter passed to the panic-ed
> -	  kernel. Please take a look at Documentation/kdump/kdump.rst
> +	  kernel. Please take a look at Documentation/admin-guide/kdump/kdump.rst
>  	  for more details about crash dumps.
>  
>  	  Usage of bzImage for capturing the crash dump is recommended as
> -- 
> 2.21.0
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
