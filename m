From: David Miller <davem@davemloft.net>
Date: Tue, 18 Feb 2014 22:05:57 +0000
Subject: Re: [PATCH v5] DT: net: document Ethernet bindings in one place
Message-Id: <20140218.170557.1748698882332547218.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201402180242.00796.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201402180242.00796.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, rob@landley.net, linux-doc@vger.kernel.org, jcmvbkbc@gmail.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 18 Feb 2014 02:41:59 +0300

> This patch is an attempt to gather the Ethernet related bindings in one file,
> like it's done in the MMC and some other subsystems. It should save some of
> the trouble of documenting several properties over and over in each binding
> document, instead only making reference to the main file.
> 
> I have used the Embedded Power Architecture(TM) Platform Requirements (ePAPR)
> standard as a base for the properties description, also documenting some ad-hoc
> properties that have been introduced over time despite having direct analogs in
> ePAPR.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks Sergei.
