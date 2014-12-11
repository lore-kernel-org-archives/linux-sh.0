From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Dec 2014 12:31:13 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: r8a73a4: Multiplatform support
Message-Id: <CANqRtoRCaAiMWDU8d0RV2cF2wMWMLfm4vHutU3jesFFcoF8Ydw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417509439-31739-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1417509439-31739-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Tue, Dec 2, 2014 at 5:37 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Enable r8a73a4 Multiplatform support for the generic r8a73a4
> machine vector.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

This for your efforts. This particular patch is fine with me.

Acked-by: Magnus Damm <damm+renesas@opensource.se>

Regarding the other patches, as discussed over chat please consider
optimising the patch order to allow merge of multiplatform merge
independently of board removal and renaming of files. Basically I
think you can add multiplatform support using the non-reference DT
file directly and not making use of any C board code.

Cheers,

/ magnus
