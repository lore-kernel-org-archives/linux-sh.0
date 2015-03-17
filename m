From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Mar 2015 09:18:36 +0000
Subject: Re: [RFC V2 0/4] prototype: switch I2C IP cores at runtime
Message-Id: <CANqRtoRLwbQ3b3nKB7doXT8vm60kp_6aW7k586e-L7n6F0NOmw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426576524-22315-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426576524-22315-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Tue, Mar 17, 2015 at 4:15 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Some SoC (like Renesas RCar Gen2) have different I2C IP cores with different
> feature sets. This is an experimental patch series to let those different IP
> cores access the same I2C bus at runtime. Finally, we have some code to talk
> about :) Unlike previous sketched versions, this one does not require a
> remove/probe-cycle of I2C bus drivers which would mean complete
> reinitialization of all connected I2C clients. However, the first two patches
> need serious discussion. So, have a look if you are interested...
>
> Please have a look at the individual patches for changes since last version.
> This is mainly code improvements and rebase to v4.0-rc4 for easier testing and
> to keep discussion alive :) These patches are only sent to the sh-list for now.
> I'd like to have consensus here before involving people from the outside.

Thanks. I think this looks rather clean myself!

This approach would also in theory allow using a GPIO bitbang driver
as one alternative I2C master, right?

If so then I'm happy because we can then keep a single DTB and yet
generic distro-kernels should be able to include GPIO bitbang support
in their kernels but may exclude other variants of I2C master
controller drivers.

Cheers,

/ magnus
