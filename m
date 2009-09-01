From: yoshii.takashi@renesas.com
Date: Tue, 01 Sep 2009 02:19:37 +0000
Subject: Re: sh7785 cache question
Message-Id: <20090901111937.69dff851.yoshii.takashi@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A7A9C73.1070000@siemens.com>
In-Reply-To: <4A7A9C73.1070000@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I think this answer solves your question better than paul's...
A: You have the question because the manual's description is insufficient.
# I'm a software engineer, and this is never an official speaking of renesas's semiconductor division.

Actually, you can use 00000000-EFFFFFFF and  F4xxxxxxxx for SH4A's cache insns.
# only F4xxxxxx is valid for SH4. 00000000-EFFFFFFF is SH4A extension.

SH7785 Hardware Manual (rej09b0261) says
> Do not execute this instruction to invalidate the memory-mapped array areas and control
> register areas for which Rn[31:24] is not H'F4, and their reserved areas (H'F0 to H'F3, H'F5 to
> H'FF).

Mmm. Perhaps two sentences has been crashed into one? I guess what they wanted to say was
Do not use this instructions onto
  the memory-mapped array areas and control register areas  for which Rn[31:24] is not H'F4.
# According to "Figure 7.4 P4 Area"  of the manual,
#  memory-mapped array areas is H'F3-H'F7,  control register areas is H'FC-H'FF
# Anyway, this does not care about lower space (H'00-H'EF), that is valid area.

And later part is additional, somewhat duplicated area assignment, as a result this is the answer
 Don't use them onto H'F0 to H'F3 and H'F5 to H'FF.

Only the condition (F0-F3,F5-FF) is clearly described in  Software manual for SH4A extensions
(rjj09b0235 written in Japanese, No English version found).
Sorry for inconvenient.

Hope this helps,
/yoshii
