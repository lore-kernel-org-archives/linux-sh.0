From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 31 Mar 2015 05:24:38 +0000
Subject: Re: [PATCH v3 1/1] spi: Using Trigger number to transmit/receive data
Message-Id: <551A2F96.2050000@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1414034053-14750-1-git-send-email-cm-hiep@jinso.co.jp> <1414034053-14750-2-git-send-email-cm-hiep@jinso.co.jp> <20150330043049.GE1568@sirena.org.uk>
In-Reply-To: <20150330043049.GE1568@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mark Brown <broonie@kernel.org>
Cc: geert+renesas@glider.be, linux-spi@vger.kernel.org, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org

Hi Mark-san

On 2015年03月30日 13:30, Mark Brown wrote:
> On Thu, Oct 23, 2014 at 12:14:13PM +0900, Cao Minh Hiep wrote:
>> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>>
>> In order to transmit and receive data when have 32 bytes of data that
>> ready has prepared on Transmit/Receive Buffer to transmit or receive.
>> Instead transmits/receives a byte data using Transmit/Receive Buffer
>> Data Triggering Number will improve the speed of transfer data.
> Applied, thanks.  It'd have helped to be more explicit about what a
> "trigger number" is here - it's not a commonly used term.  "Trigger
> level" is more normal.
Thank you very much!
Hiep.
