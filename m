From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 26 Jan 2011 18:28:08 +0000
Subject: Re: linux 2.6.37+ seems to go to sleep
Message-Id: <201101261928.09358.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In which arch/sh/boards/ could I study hoe to setup the clock framework for my 
board?
P.S.
I tried to build RSK+ board, not for mine, and running on mine teh kernel does 
not work.

Thanks in advance

On Thursday 20 January 2011 10:01:23 Magnus Damm wrote:
> On Thu, Jan 20, 2011 at 5:43 PM, Fabio Giovagnini
> 
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Can I be sure the BRR setting algorithm used is proper for my sh2a 7203?
> 
> The BRR setting depends on the clock framework. And the clock
> framework settings may depend on your board.
> 
> > Do you know if anyone tested teh last linux version on rsk+ 7203?
> 
> Not sure. I recall hacking on timer code on rsk7203 in April 2009,
> after that I have no idea about the status.
> 
> / magnus

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
