From: Steve.Glendinning@smsc.com
Date: Thu, 06 Nov 2008 11:06:52 +0000
Subject: smsc911x in 2.6.29
Message-Id: <OF18129353.0F9B8038-ON802574F9.003C4672-802574F9.003D1A48@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,

I recently posted a patchset on netdev to replace smc911x with a new 
vendor-supported smsc911x driver:

    http://marc.info/?l=linux-netdev&m2588138425309&w=4

Jeff Garzik has merged the driver itself for net-next (2.6.29).

3 of the patches convert sh platforms (rsk7203, ap325rxa & magicpanelr2) 
from one driver to the other, but I don't have access to any of these 
platforms to test.  Can anyone here help?

Please let me know if anyone wants me to re-send them the whole patchset 
(6 patches).

Regards,
--
Steve Glendinning
SMSC GmbH
m: +44 777 933 9124
e: steve.glendinning@smsc.com


