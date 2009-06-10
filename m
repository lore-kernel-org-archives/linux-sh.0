From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Jun 2009 10:55:22 +0000
Subject: Re: [PATCH] sh: fix clock for sh7785
Message-Id: <aec7e5c30906100355n355f6200sbfdd0d3f3e464f8a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A2F461A.8080506@renesas.com>
In-Reply-To: <4A2F461A.8080506@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Jun 10, 2009 at 2:35 PM, Yoshihiro
Shimoda<shimoda.yoshihiro@renesas.com> wrote:
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> ---
> =A0Could you apply this patch to linux-2.6.30?
> =A0If impossible, this patch is not necessary because clock-sh7785.c will=
 modify
> =A0in linux-2.6.31.

This patch looks like a workaround for the issue solved by this patch:

http://patchwork.kernel.org/patch/22299/

Or am I misunderstanding?

/ magnus
