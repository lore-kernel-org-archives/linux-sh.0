From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Mar 2010 23:00:48 +0000
Subject: Re: Now I'm starting to understand
Message-Id: <aec7e5c31003171600p4fbdf62fq4685cac3bab7cfa7@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003171946.13342.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003171946.13342.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

On Thu, Mar 18, 2010 at 3:46 AM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Hi, all
> if I undersatnd properly, the main gaol of the linux sh porting is to reduce
> at maximum the effort needed to migrate from a board to another having the same
> MCU / CPU.

Correct! The Linux kernel tries to share as much code as possible in general.

> In this case all you need is to write the files of arch/sh/board/<yourboard>*.c
> files.
> But where is teh documentation about the meaning of all the structures and
> flags you can read in setup.c for example?

Many files change with every new release of the Linux kernel, so the
only way is to read the source code and submit your code so other
people change it for you in the future if needed.

Cheers,

/ magnus
