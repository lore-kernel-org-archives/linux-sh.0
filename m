From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 21 Jan 2008 08:38:40 +0000
Subject: Re: Hi, all,
Message-Id: <200801210938.41097.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200801201730.07407.vapier@gentoo.org>
In-Reply-To: <200801201730.07407.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi all,
this are more info.
Please tell me is this enough or you need more.
The kernel headers for buildign stage 2 of toolchain is 2.6.17 patched for =

sh2a 7203 by MCP data. If needed I attach the patch.


fgiovagnini@aurio02:~/sh7203-uClinux-1.4/build/target/bin> ./sh-linux-g++=20
-dumpversion
3.4.6

fgiovagnini@aurio02:~/sh7203-uClinux-1.4/build/target/bin> ./sh-linux-g++=20
-dumpmachine
sh-linux

fgiovagnini@aurio02:~/sh7203-uClinux-1.4/build/target/bin> ./sh-linux-g++=20
-print-multi-lib
.;
pic;@fPIC
mb;@mb
m3e;@m3e
m4;@m4
mb/m3e;@mb@m3e
mb/m4;@mb@m4
pic/mb;@fPIC@mb
pic/m3e;@fPIC@m3e
pic/m4;@fPIC@m4
pic/mb/m3e;@fPIC@mb@m3e
pic/mb/m4;@fPIC@mb@m4

uClib is 0.9.27 with this config
#
# Automatically generated make config: don't edit
#
# TARGET_alpha is not set
# TARGET_arm is not set
# TARGET_bfin is not set
# TARGET_cris is not set
# TARGET_e1 is not set
# TARGET_frv is not set
# TARGET_h8300 is not set
# TARGET_i386 is not set
# TARGET_i960 is not set
# TARGET_m68k is not set
# TARGET_microblaze is not set
# TARGET_mips is not set
# TARGET_nios is not set
# TARGET_nios2 is not set
# TARGET_powerpc is not set
TARGET_sh=3Dy
# TARGET_sparc is not set
# TARGET_v850 is not set

#
# Target Architecture Features and Options
#
HAVE_ELF=3Dy
ARCH_SUPPORTS_LITTLE_ENDIAN=3Dy
TARGET_ARCH=3D"sh"
ARCH_SUPPORTS_BIG_ENDIAN=3Dy
HAVE_DOT_HIDDEN=3Dy
CONFIG_SH2=3Dy
# CONFIG_SH3 is not set
# CONFIG_SH4 is not set
# CONFIG_SH5 is not set
# ARCH_LITTLE_ENDIAN is not set
ARCH_BIG_ENDIAN=3Dy
ARCH_HAS_NO_MMU=3Dy
UCLIBC_HAS_FLOATS=3Dy
HAS_FPU=3Dy
DO_C99_MATH=3Dy
WARNINGS=3D"-Wall"
KERNEL_SOURCE=3D"$(KERNEL_SOURCE_DIRECTORY)"
UCLIBC_UCLINUX_BROKEN_MUNMAP=3Dy
EXCLUDE_BRK=3Dy
C_SYMBOL_PREFIX=3D""
HAVE_DOT_CONFIG=3Dy

#
# General Library Settings
#
# HAVE_NO_PIC is not set
# DOPIC is not set
# HAVE_NO_SHARED is not set
ARCH_HAS_NO_LDSO=3Dy
# UCLIBC_CTOR_DTOR is not set
# HAS_NO_THREADS is not set
UCLIBC_HAS_THREADS=3Dy
# PTHREADS_DEBUG_SUPPORT is not set
# UCLIBC_HAS_LFS is not set
MALLOC=3Dy
# MALLOC_SIMPLE is not set
# MALLOC_STANDARD is not set
# MALLOC_GLIBC_COMPAT is not set
# UCLIBC_DYNAMIC_ATEXIT is not set
HAS_SHADOW=3Dy
UNIX98PTY_ONLY=3Dy
ASSUME_DEVPTS=3Dy
UCLIBC_HAS_TM_EXTENSIONS=3Dy
UCLIBC_HAS_TZ_CACHING=3Dy
UCLIBC_HAS_TZ_FILE=3Dy
UCLIBC_HAS_TZ_FILE_READ_MANY=3Dy
UCLIBC_TZ_FILE_PATH=3D"/etc/TZ"

#
# Networking Support
#
# UCLIBC_HAS_IPV6 is not set
UCLIBC_HAS_RPC=3Dy
UCLIBC_HAS_FULL_RPC=3Dy

#
# String and Stdio Support
#
UCLIBC_HAS_STRING_GENERIC_OPT=3Dy
UCLIBC_HAS_STRING_ARCH_OPT=3Dy
UCLIBC_HAS_CTYPE_TABLES=3Dy
UCLIBC_HAS_CTYPE_SIGNED=3Dy
UCLIBC_HAS_CTYPE_UNSAFE=3Dy
# UCLIBC_HAS_CTYPE_CHECKED is not set
# UCLIBC_HAS_CTYPE_ENFORCED is not set
UCLIBC_HAS_WCHAR=3Dy
# UCLIBC_HAS_LOCALE is not set
# UCLIBC_HAS_HEXADECIMAL_FLOATS is not set
# UCLIBC_HAS_GLIBC_CUSTOM_PRINTF is not set
UCLIBC_PRINTF_SCANF_POSITIONAL_ARGS=3D9
# UCLIBC_HAS_SCANF_GLIBC_A_FLAG is not set
# UCLIBC_HAS_STDIO_BUFSIZ_NONE is not set
# UCLIBC_HAS_STDIO_BUFSIZ_256 is not set
# UCLIBC_HAS_STDIO_BUFSIZ_512 is not set
# UCLIBC_HAS_STDIO_BUFSIZ_1024 is not set
# UCLIBC_HAS_STDIO_BUFSIZ_2048 is not set
UCLIBC_HAS_STDIO_BUFSIZ_4096=3Dy
# UCLIBC_HAS_STDIO_BUFSIZ_8192 is not set
UCLIBC_HAS_STDIO_BUILTIN_BUFFER_NONE=3Dy
# UCLIBC_HAS_STDIO_BUILTIN_BUFFER_4 is not set
# UCLIBC_HAS_STDIO_BUILTIN_BUFFER_8 is not set
UCLIBC_HAS_STDIO_GETC_MACRO=3Dy
UCLIBC_HAS_STDIO_PUTC_MACRO=3Dy
UCLIBC_HAS_STDIO_AUTO_RW_TRANSITION=3Dy
# UCLIBC_HAS_FOPEN_EXCLUSIVE_MODE is not set
# UCLIBC_HAS_GLIBC_CUSTOM_STREAMS is not set
# UCLIBC_HAS_PRINTF_M_SPEC is not set
UCLIBC_HAS_ERRNO_MESSAGES=3Dy
# UCLIBC_HAS_SYS_ERRLIST is not set
UCLIBC_HAS_SIGNUM_MESSAGES=3Dy
# UCLIBC_HAS_SYS_SIGLIST is not set
UCLIBC_HAS_GNU_GETOPT=3Dy

#
# Big and Tall
#
UCLIBC_HAS_REGEX=3Dy
# UCLIBC_HAS_WORDEXP is not set
UCLIBC_HAS_FTW=3Dy
UCLIBC_HAS_GLOB=3Dy

#
# Library Installation Options
#
RUNTIME_PREFIX=3D"/"
DEVEL_PREFIX=3D"/usr/"

#
# uClibc security related options
#
# UCLIBC_SECURITY is not set

#
# uClibc development/debugging options
#
# DODEBUG is not set
# DOASSERTS is not set
# UCLIBC_MALLOC_DEBUGGING is not set
# UCLIBC_MJN3_ONLY is not set



Alle 08:46, luned=EC 21 gennaio 2008, Carmelo AMOROSO ha scritto:
> Mike Frysinger wrote:
> > On Sunday 20 January 2008, Mike Frysinger wrote:
> >> On Sunday 20 January 2008, Fabio Giovagnini wrote:
> >>> I have such a problem with.
> >>> sh-uclibc-g++ 3.4.6
> >>>
> >>> /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc/unwind-dw=
2-
> >>>fd e- glibc.c:291: undefined reference to `dl_iterate_phdr'
> >>>
> >>> How can I solve.
> >>> Any suggestion will be appreciated.
> >>
> >> a one line error isnt exactly useful ... you didnt say what version of
> >> uClibc you're using or what you're using for a build system.
> >
> > and more importantly, what exactly are you doing
> > -mike
>
> Hi Mike,
> I think that Fabio is trying to linking statically a C++ application
> against uClibc. If so, (Fabio please clarify), the problem is extactly
> the same
> I posted on uClibc list last week (mmove _dl_iterate_phdr from libdl.a
> to libc.a).
>
> I have a already fixed it for nptl/sh4 branch... I'm just now merging
> the patch
> for the uClibc branch and post it for a wider review on uClibc.
>
> I'll put Fabio into the loop.. anyway Fabio should post his full command
> line
> used to build/link his application.
>
> Cheers,
> Carmelo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Fabio Giovagnini

Aurion s.r.l.
via degli orti 11,
40050 Funo di Argelato (BO)
P.I e C.F.
00885711200
Tel. +39.335.8350919
Fax +39.051.8659009

www.aurion-tech.com

account telefono VoIP skype (www.skype.com):
aurion.giovagnini
