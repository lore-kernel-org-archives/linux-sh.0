From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 14 Sep 2009 05:12:34 +0000
Subject: Re: Recent assembler sign extension patch
Message-Id: <29ab51dc0909132212u63862efbm8a0359e9efc038be@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090827132813.GB4668@console-pimps.org>
In-Reply-To: <20090827132813.GB4668@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

2009/8/28 Matt Fleming <matt@console-pimps.org>:
> On Thu, Aug 27, 2009 at 03:39:36PM +0100, Stuart MENEFY wrote:
>>
>> Strange, this works OK for me although I'm using a slightly older
>> as (2.18.50.0.8.20090602). However I did see this error with gas
>> built on x86-64 - there is a bug in the assembler in this area
>> which assumes longs are 32 bit (from memory). Could that be why
>> you're seeing this?
>>
>
> Bingo! Good call there, Stuart. It is indeed a 64-bit host bug in the
> assembler. The bug is still present in the latest binutils sources. I've
> attached a patch that I will push towards the binutils folks.
>
>>
>> Its one of the things which has always bugged me about the SH assembler,
>> that its checks on the immediate argument don't take into account
>> whether the instruction sign extends its argument. To me more precise,
>> it checks all immediates are in the range -256 to +255.
>>
>> So I modified binutils to take into account whether the instruction
>> sign extends or not, and found that entry.S had a bug:
>>
>
> Are you planning on submitting these assembler changes upstream? It'd be
> cool if you can.
>
>> @@ -676,8 +676,9 @@ need_resched:
>>
>> =A0 =A0 =A0 =A0 mov =A0 =A0 #OFF_SR, r0
>> =A0 =A0 =A0 =A0 mov.l =A0 @(r0,r15), r0 =A0 =A0 =A0 =A0 =A0 ! get status=
 register
>> - =A0 =A0 =A0 and =A0 =A0 #0xf0, r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ! interr=
upts off (exception path)?
>> - =A0 =A0 =A0 cmp/eq =A0#0xf0, r0
>> + =A0 =A0 =A0 shlr =A0 =A0r0
>> + =A0 =A0 =A0 and =A0 =A0 #(0xf0>>1), r0
>> + =A0 =A0 =A0 cmp/eq =A0#(0xf0>>1), r0 =A0 =A0 =A0 =A0 =A0! interrupts o=
ff (exception path)?
>> =A0 =A0 =A0 =A0 bt =A0 =A0 =A0noresched
>> =A0 =A0 =A0 =A0 mov.l =A0 3f, r0
>> =A0 =A0 =A0 =A0 jsr =A0 =A0 @r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
! call preempt_schedule_irq
>>
>> Here the "and" doesn't sign extend, but the "cmp/eq" does.
>>
>> All the other changes are to clarify when sign extension is actually
>> taking place. Personally I'd rather see
>> =A0 add #0xffffffe0, r0
>> than
>> =A0 add #0xe0, r0
>> and have to remember that sign extension is taking place. This also happ=
ens
>> to be what my modified assembler requires!
>>
>> Stuart
>
> Ah right, I understand now. That makes sense.
>
>
> Index: gas/config/tc-sh.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> RCS file: /cvs/src/src/gas/config/tc-sh.c,v
> retrieving revision 1.132
> diff -u -r1.132 tc-sh.c
> --- gas/config/tc-sh.c =A024 Jul 2009 11:45:00 -0000 =A0 =A0 =A01.132
> +++ gas/config/tc-sh.c =A027 Aug 2009 20:09:14 -0000
> @@ -156,6 +156,11 @@
> =A0#define ENCODE_RELAX(what,length) (((what) << 4) + (length))
> =A0#define GET_WHAT(x) ((x>>4))
>
> +/* Truncate and sign-extend at 32 bits, so that building on a 64-bit host
> + =A0 gives identical results to a 32-bit host. =A0*/
> +#define TRUNC(X) =A0 =A0 =A0 ((long) (X) & 0xffffffff)
> +#define SEXT(X) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((TRUNC (X) ^ 0x80000000)=
 - 0x80000000)
> +
> =A0/* These are the three types of relaxable instruction. =A0*/
> =A0/* These are the types of relaxable instructions; except for END which=
 is
> =A0 =A0a marker. =A0*/
> @@ -4183,7 +4188,7 @@
> =A0 =A0 =A0 =A0val =3D ((val >> shift)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 | ((long) -1 & ~ ((long) -1 >> shift)));
> =A0 =A0 }
> - =A0if (max !=3D 0 && (val < min || val > max))
> + =A0if (max !=3D 0 && (SEXT(val) < min || SEXT(val) > max))
> =A0 =A0 as_bad_where (fixP->fx_file, fixP->fx_line, _("offset out of rang=
e"));
> =A0 else if (max !=3D 0)
> =A0 =A0 /* Stop the generic code from trying to overlow check the value a=
s well.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

I think that I should cope in a kernel, because this problem is thing
by the limit of mov.
# mov of this case supports only 8bit.

diff --git a/arch/sh/include/asm/entry-macros.S
b/arch/sh/include/asm/entry-macros.S
index cc43a55..64fd0de 100644
--- a/arch/sh/include/asm/entry-macros.S
+++ b/arch/sh/include/asm/entry-macros.S
@@ -7,7 +7,7 @@
    .endm

    .macro  sti
-   mov #0xfffffff0, r11
+   mov #0xf0, r11
    extu.b  r11, r11
    not r11, r11
    stc sr, r10
diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.S
index 0151933..4e3dc2d 100644
--- a/arch/sh/kernel/cpu/sh3/entry.S
+++ b/arch/sh/kernel/cpu/sh3/entry.S
@@ -260,7 +260,7 @@ restore_all:
    !
    ! Calculate new SR value
    mov k3, k2          ! original SR value
-   mov #0xfffffff0, k1
+   mov #0xf0, k1
    extu.b  k1, k1
    not k1, k1
    and k1, k2          ! Mask original SR value
diff --git a/arch/sh/lib/__clear_user.S b/arch/sh/lib/__clear_user.S
index db1dca7..31b692e 100644
--- a/arch/sh/lib/__clear_user.S
+++ b/arch/sh/lib/__clear_user.S
@@ -11,7 +11,7 @@
 ENTRY(__clear_user)
    !
    mov #0, r0
-   mov #0xffffffe0, r1
+   mov #0xe0, r1
    !
    ! r4..(r4+31)&~32      -------- not aligned [ Area 0 ]
    ! (r4+31)&~32..(r4+r5)&~32 -------- aligned [ Area 1 ]

Best regards,
  Nobuhiro
--=20
Nobuhiro Iwamatsu
