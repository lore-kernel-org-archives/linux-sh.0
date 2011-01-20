From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Jan 2011 08:17:48 +0000
Subject: Re: linux 2.6.37+ seems to go to sleep
Message-Id: <AANLkTi=6Ya2z7Hx=Kfvoj2sCy0fUrwvt1Fxt+ZRy3QjZ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

On Thu, Jan 20, 2011 at 3:26 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Hi Magnus,
> could you write to me please the exact cmdline to put in boot option and / or
> bootargs env variable of u-boot?

You know, you can always grep the default kernel configurations:

For the rsk7302 board try this:

$ grep CONFIG_CMDLINE arch/sh/configs/rsk7203_defconfig
CONFIG_CMDLINE_OVERWRITE=y
CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=serial ignore_loglevel"
$

The earlyprintk format seems a bit outdated though - it unfortunately
looks like too few people are submitting rsk7302 patches upstream.

Try using this kernel command line:
CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=sh-sci.0,115200
ignore_loglevel"

You can also look at this commit for more information about
earlyprintk and sh-sci:
$ git log 7b6fd3bf82c4901f6ba0101ba71a5c507c24f9cf

/ magnus
