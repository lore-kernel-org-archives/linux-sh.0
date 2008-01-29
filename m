From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 29 Jan 2008 08:32:33 +0000
Subject: Re: Hi all, how could I check if my compiler use fpu instruction?
Message-Id: <200801290932.33223.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200801282208.08210.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200801282208.08210.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Sorry Paul, sorry everybody.
When I'm tierd I'm not so smart.

Thanks a lot for the answer.
arch/sh/Makefile is related to kernel tree, rigth?

Thanks and sorry again.



Alle 01:49, marted=EC 29 gennaio 2008, Paul Mundt ha scritto:
> It is incredibly difficult to reply to your mail when you insist on
> putting the body of your text in the subject line. Please use a more
> meaningful subject and actually use the body for something other than
> your .sig, thanks.
>
> Regarding FP use, this depends on your target, and on your CFLAGS. If
> you're using a target that supports an FPU, FP instructions are generated
> by default. You will need to explicitly inhibit FP instruction generation
> if you do not want it. You can look at arch/sh/Makefile for various ways
> we try to prevent the compiler from generating FP instructions ("try" is
> operative here, since GCC often has its own ideas about things).
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
