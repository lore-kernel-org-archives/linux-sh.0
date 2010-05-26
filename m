From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 26 May 2010 08:00:27 +0000
Subject: Re: LCDC of 7203
Message-Id: <AANLkTimJ-9GFWzpu3oPwQkal-JGAgluIcDIE1JO7P4rD@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201005241912.44976.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201005241912.44976.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 26, 2010 at 3:54 AM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> There are some low cost LCD having a parallel interface with the synch signals
> and 16 / 18 bit of data.
> The sh2a LCDC can manage such LCD panels
>
> Am I right or not?

I don't know, you will have to check the data sheet.

It sounds like you are describing SYS-16/18, but it may also be RGB
with 6 bits for each color. Some LCDC hardware blocks like the
SH-Mobile support both RGB and SYS, but others only support one of the
interface types.

Cheers,

/ magnus
