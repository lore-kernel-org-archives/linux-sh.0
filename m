From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Date: Fri, 28 Nov 2014 01:26:27 +0000
Subject: [PATCH v2 1/7] pinctrl: pinconf-generic: Infer map type from DT property
Message-Id: <1417137993-8337-2-git-send-email-soren.brinkmann@xilinx.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

With the new 'groups' property, the DT parser can infer the map type
from the fact whether 'pins' or 'groups' is used to specify the pin
group to work on.
To maintain backwards compatibitliy with current usage of the DT
binding, this is only done when an invalid map type is passed to the
parsing function.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
Changes since RFC v2:
 - none
---
 drivers/pinctrl/pinconf-generic.c       | 17 ++++++++++++++---
 include/linux/pinctrl/pinconf-generic.h |  7 +++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-ge=
neric.c
index f78b416d7984..1e782a0d6e48 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -264,6 +264,7 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_de=
v *pctldev,
 	unsigned reserve;
 	struct property *prop;
 	const char *group;
+	const char *dt_pin_specifier =3D "pins";
=20
 	ret =3D of_property_read_string(np, "function", &function);
 	if (ret < 0) {
@@ -284,10 +285,20 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_=
dev *pctldev,
 		reserve++;
 	if (num_configs)
 		reserve++;
+
 	ret =3D of_property_count_strings(np, "pins");
 	if (ret < 0) {
-		dev_err(dev, "could not parse property pins\n");
-		goto exit;
+		ret =3D of_property_count_strings(np, "groups");
+		if (ret < 0) {
+			dev_err(dev, "could not parse property pins/groups\n");
+			goto exit;
+		}
+		if (type =3D PIN_MAP_TYPE_INVALID)
+			type =3D PIN_MAP_TYPE_CONFIGS_GROUP;
+		dt_pin_specifier =3D "groups";
+	} else {
+		if (type =3D PIN_MAP_TYPE_INVALID)
+			type =3D PIN_MAP_TYPE_CONFIGS_PIN;
 	}
 	reserve *=3D ret;
=20
@@ -296,7 +307,7 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_de=
v *pctldev,
 	if (ret < 0)
 		goto exit;
=20
-	of_property_for_each_string(np, "pins", prop, group) {
+	of_property_for_each_string(np, dt_pin_specifier, prop, group) {
 		if (function) {
 			ret =3D pinctrl_utils_add_map_mux(pctldev, map,
 					reserved_maps, num_maps, group,
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctr=
l/pinconf-generic.h
index d578a60eff23..b6dedfbfce69 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -174,6 +174,13 @@ static inline int pinconf_generic_dt_node_to_map_pin(
 			PIN_MAP_TYPE_CONFIGS_PIN);
 }
=20
+static inline int pinconf_generic_dt_node_to_map_all(
+		struct pinctrl_dev *pctldev, struct device_node *np_config,
+		struct pinctrl_map **map, unsigned *num_maps)
+{
+	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
+			PIN_MAP_TYPE_INVALID);
+}
 #endif
=20
 #endif /* CONFIG_GENERIC_PINCONF */
--=20
2.1.3.1.ge241007

