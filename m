From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Jan 2011 09:01:23 +0000
Subject: Re: linux 2.6.37+ seems to go to sleep
Message-Id: <AANLkTimUnPP+s-bG5Y_21Tg-kD4n5yZAFtwkpBq=1wO-@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 20, 2011 at 5:43 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Can I be sure the BRR setting algorithm used is proper for my sh2a 7203?

The BRR setting depends on the clock framework. And the clock
framework settings may depend on your board.

> Do you know if anyone tested teh last linux version on rsk+ 7203?

Not sure. I recall hacking on timer code on rsk7203 in April 2009,
after that I have no idea about the status.

/ magnus
