From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 21 Jun 2011 18:27:33 +0000
Subject: Re: [PATCH 02/02] virtio: Add virtio platform driver
Message-Id: <BANLkTi=tut=Y4fc4tkT8wt_q1azJOYaDoQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110621102605.1382.90232.sendpatchset@t400s> <20110621102623.1382.71841.sendpatchset@t400s>
In-Reply-To: <20110621102623.1382.71841.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, horms@verge.net.au, mst@redhat.com, iws@ovro.caltech.edu

On Tue, Jun 21, 2011 at 06:26, Magnus Damm wrote:
> +config VIRTIO_PLATFORM
> +       tristate "Platform driver for virtio devices (EXPERIMENTAL)"
> +       select VIRTIO
> +       select VIRTIO_RING
> +       select VIRTIO_LGUEST
> +       ---help---
> +        This drivers provides support for virtio based paravirtual device
> +        drivers over a platform bus.
> +
> +        If unsure, say N.

be nice to add a note as to the name of the module if the user selects "M"

> --- /dev/null
> +++ work/drivers/virtio/virtio_platform.c       2011-03-03 16:07:31.000000000 +0900
> --- /dev/null
> +++ work/include/linux/virtio_platform.h        2011-03-03 15:56:54.000000000 +0900

both files lack a comment block at the top
/*
 * one line desc of file
 *
 * copyright
 *
 * license blurb
 */
-mike
