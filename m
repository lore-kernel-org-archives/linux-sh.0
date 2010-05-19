From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 May 2010 08:46:48 +0000
Subject: Re: [PATCH/RFC] sh: simplify register access macros in the SCI serial
Message-Id: <AANLkTikpVyZaBPbhI3rn0hZnGT6OHYxtOfveuV__VDjA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005191028560.3099@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005191028560.3099@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, May 19, 2010 at 5:34 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> well, actually, I think, as long size is a constant, I think, even the
> original macros would be resolved at compile time, wouldn't they? And they
> have the advantage to also supporting non-constants. Whereas my version
> explicitly requires constants, but looks a bit easier to me... Anyway, I
> thought I just propose it, but I wouldn't be too upset if it just gets
> dropped.
>
> =A0drivers/serial/sh-sci.h | =A0 36 ++++++++++++++----------------------
> =A01 files changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
> index f70c49f..151c41f 100644
> --- a/drivers/serial/sh-sci.h
> +++ b/drivers/serial/sh-sci.h
> @@ -307,17 +307,9 @@
> =A0#define SCI_EVENT_WRITE_WAKEUP 0
>
> =A0#define SCI_IN(size, offset) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0if ((size) =3D 8) { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0return ioread8(port->membase + (offset)); =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0\
> - =A0} else { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0return ioread16(port->membase + (offset)); =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 \
> - =A0}
> + =A0 =A0return ioread ## size(port->membase + (offset));
> =A0#define SCI_OUT(size, offset, value) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 \
> - =A0if ((size) =3D 8) { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0iowrite8(value, port->membase + (offset)); =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 \
> - =A0} else if ((size) =3D 16) { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0iowrite16(value, port->membase + (offset)); =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0\
> - =A0}
> + =A0 =A0iowrite ## size(value, port->membase + (offset));

This doesn't work. size =3D 0 means no operation.

/ magnus
