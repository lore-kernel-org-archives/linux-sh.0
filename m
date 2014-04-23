From: Rob Herring <robherring2@gmail.com>
Date: Wed, 23 Apr 2014 13:12:50 +0000
Subject: Re: [PATCH 22/33] ARM: shmobile: Use r8a7740 suffix for i2c, mmcif, fsi2 compat strings
Message-Id: <CAL_JsqKOi-mQ=xDDyP72RB1kN3_Ak114kMrbntsizxEehwVXuQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
 <5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
In-Reply-To: <5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Apr 22, 2014 at 8:25 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
>
> Add "renesas,*-r8a7740" to the compatible strings for consistency with other
> devices.

Generally, it is <vendor>,<chip>-<device> as the preferred ordering
which is also consistent with your more generic name.

Rob
