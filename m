From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jun 2009 08:28:23 +0000
Subject: Re: Question about USB module of sh2a 7286
Message-Id: <aec7e5c30906090128m36e99060v4546627ed473b55b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200906081608.32208.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200906081608.32208.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 8, 2009 at 11:08 PM, Fabio
Giovagnini<fabio.giovagnini@aurion-tech.com> wrote:
> Hi All,
> where could I find infos and examples about the USB on chip periferals for
> sh2a 7286 uController?

The USBF block in the sh7280 datasheet looks similar to the USBF in
sh7720 and sh7763. I could not find any identical USBF block, but I
only spent a few minutes searching. Maybe the "sh_udc" driver can be
modified to support this hardware?

/ magnus
