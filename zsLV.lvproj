<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="14008000">
	<Property Name="SMProvider.SMVersion" Type="Int">201310</Property>
	<Item Name="我的电脑" Type="My Computer">
		<Property Name="IOScan.Faults" Type="Str"></Property>
		<Property Name="IOScan.NetVarPeriod" Type="UInt">100</Property>
		<Property Name="IOScan.NetWatchdogEnabled" Type="Bool">false</Property>
		<Property Name="IOScan.Period" Type="UInt">10000</Property>
		<Property Name="IOScan.PowerupMode" Type="UInt">0</Property>
		<Property Name="IOScan.Priority" Type="UInt">9</Property>
		<Property Name="IOScan.ReportModeConflict" Type="Bool">true</Property>
		<Property Name="IOScan.StartEngineOnDeploy" Type="Bool">false</Property>
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">我的电脑/VI服务器</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">我的电脑/VI服务器</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="Basic" Type="Folder">
			<Item Name="ctl" Type="Folder" URL="../ctl">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="Global_var" Type="Folder" URL="../Global_var">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="WrapperFunc" Type="Folder" URL="../Wrapper_lib/WrapperFunc">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="BasicFunc" Type="Folder" URL="../BasicFunc">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="Source" Type="Folder" URL="../Source">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="Wrapper.lvlib" Type="Library" URL="../Wrapper_lib/Wrapper.lvlib"/>
		</Item>
		<Item Name="Coordinator_state" Type="Folder">
			<Item Name="sub_vi" Type="Folder" URL="../CoordinatorUI_lib/sub_vi">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="ROSMessage" Type="Folder" URL="../CoordinatorUI_lib/ROSMessage">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="CoordinatorUI.lvlib" Type="Library" URL="../CoordinatorUI_lib/CoordinatorUI.lvlib"/>
			<Item Name="States.lvlib" Type="Library" URL="../States_lib/States.lvlib"/>
		</Item>
		<Item Name="Map" Type="Folder">
			<Item Name="MapBuilder" Type="Folder" URL="../Map_lib/MapBuilder">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="Map.lvlib" Type="Library" URL="../Map_lib/Map.lvlib"/>
		</Item>
		<Item Name="Voice" Type="Folder">
			<Item Name="speech" Type="Folder" URL="../Voice_lib/VoiceControl/speech">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="Voice.lvlib" Type="Library" URL="../Voice_lib/Voice.lvlib"/>
		</Item>
		<Item Name="RemoteP3AT" Type="Folder">
			<Item Name="ROSMessageParser" Type="Folder" URL="../RemoteP3AT_lib/ROSMessageParser">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="ROSMessageBuilder" Type="Folder" URL="../RemoteP3AT_lib/ROSMessageBuilder">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="ROSExample" Type="Folder" URL="../RemoteP3AT_lib/ROSExample">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="RemoteP3AT.lvlib" Type="Library" URL="../RemoteP3AT_lib/RemoteP3AT.lvlib"/>
		</Item>
		<Item Name="GlobalPlanner" Type="Folder">
			<Item Name="PathControl" Type="Folder" URL="../GlobalPlanner_lib/PathControl">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="PathPlan6" Type="Folder" URL="../GlobalPlanner_lib/PathPlan6">
				<Property Name="NI.DISK" Type="Bool">true</Property>
			</Item>
			<Item Name="GlobalPlanner.lvlib" Type="Library" URL="../GlobalPlanner_lib/GlobalPlanner.lvlib"/>
		</Item>
		<Item Name="DebugTool" Type="Folder">
			<Item Name="EventsLogUI.lvlib" Type="Library" URL="../EventsLogUI_lib/EventsLogUI.lvlib"/>
			<Item Name="UnitTest.lvlib" Type="Library" URL="../UnitTest_lib/UnitTest.lvlib"/>
		</Item>
		<Item Name="zsLaunch.lvlib" Type="Library" URL="../zsLaunch_lib/zsLaunch.lvlib"/>
		<Item Name="JoyStick.lvlib" Type="Library" URL="../JoyStick_lib/JoyStick.lvlib"/>
		<Item Name="ControlPanel.lvlib" Type="Library" URL="../ControlPanel_lib/ControlPanel.lvlib"/>
		<Item Name="LaunchCOUI.vi" Type="VI" URL="../zsLaunch_lib/Launcher/LaunchCOUI.vi"/>
		<Item Name="依赖关系" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Acquire Input Data.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Acquire Input Data.vi"/>
				<Item Name="Actor Framework.lvlib" Type="Library" URL="/&lt;vilib&gt;/ActorFramework/Actor Framework.lvlib"/>
				<Item Name="Close Input Device.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Close Input Device.vi"/>
				<Item Name="closeJoystick.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeJoystick.vi"/>
				<Item Name="closeKeyboard.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeKeyboard.vi"/>
				<Item Name="closeMouse.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeMouse.vi"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="ErrorDescriptions.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/ErrorDescriptions.vi"/>
				<Item Name="errorList.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/errorList.vi"/>
				<Item Name="Initialize Joystick.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Initialize Joystick.vi"/>
				<Item Name="joystickAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/joystickAcquire.vi"/>
				<Item Name="keyboardAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/keyboardAcquire.vi"/>
				<Item Name="LMH-Xbox-One-Controller.lvlib" Type="Library" URL="/&lt;vilib&gt;/MakerHub/Xbox-One-Controller/LMH-Xbox-One-Controller.lvlib"/>
				<Item Name="mouseAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/mouseAcquire.vi"/>
				<Item Name="Query Input Devices.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Query Input Devices.vi"/>
				<Item Name="UDP Multicast Open.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/UDP Multicast Open.vi"/>
				<Item Name="UDP Multicast Read-Only Open.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/UDP Multicast Read-Only Open.vi"/>
				<Item Name="UDP Multicast Read-Write Open.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/UDP Multicast Read-Write Open.vi"/>
				<Item Name="UDP Multicast Write-Only Open.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/UDP Multicast Write-Only Open.vi"/>
				<Item Name="System Exec.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/system.llb/System Exec.vi"/>
				<Item Name="compatCalcOffset.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatCalcOffset.vi"/>
				<Item Name="compatOpenFileOperation.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatOpenFileOperation.vi"/>
				<Item Name="compatFileDialog.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatFileDialog.vi"/>
				<Item Name="Open_Create_Replace File.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/Open_Create_Replace File.vi"/>
				<Item Name="Write to XML File(array).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Write to XML File(array).vi"/>
				<Item Name="Write to XML File(string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Write to XML File(string).vi"/>
				<Item Name="Write to XML File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Write to XML File.vi"/>
				<Item Name="Read From XML File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Read From XML File.vi"/>
				<Item Name="Read From XML File(array).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Read From XML File(array).vi"/>
				<Item Name="ParseXMLFragments.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/ParseXMLFragments.vi"/>
				<Item Name="FindFirstTag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindFirstTag.vi"/>
				<Item Name="FindEmptyElement.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindEmptyElement.vi"/>
				<Item Name="FindElement.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindElement.vi"/>
				<Item Name="FindMatchingCloseTag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindMatchingCloseTag.vi"/>
				<Item Name="FindCloseTagByName.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindCloseTagByName.vi"/>
				<Item Name="FindElementStartByName.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindElementStartByName.vi"/>
				<Item Name="Read From XML File(string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Read From XML File(string).vi"/>
				<Item Name="State Actor.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/NI/Actors/State Actor/State Actor/State Actor.lvclass"/>
				<Item Name="NI_Matrix.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/Matrix/NI_Matrix.lvlib"/>
				<Item Name="Read From Spreadsheet File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File.vi"/>
				<Item Name="Read From Spreadsheet File (DBL).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (DBL).vi"/>
				<Item Name="Read Lines From File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read Lines From File.vi"/>
				<Item Name="Read From Spreadsheet File (I64).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (I64).vi"/>
				<Item Name="Read From Spreadsheet File (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (string).vi"/>
				<Item Name="IMAQ Image.ctl" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/IMAQ Image.ctl"/>
				<Item Name="IMAQ Create" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ Create"/>
				<Item Name="Image Type" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/Image Type"/>
				<Item Name="NI_Kinematics.lvlib" Type="Library" URL="/&lt;vilib&gt;/robotics/Kinematics/NI_Kinematics.lvlib"/>
				<Item Name="NI_AALPro.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALPro.lvlib"/>
				<Item Name="NI_AALBase.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALBase.lvlib"/>
				<Item Name="Move Pen.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Move Pen.vi"/>
				<Item Name="Draw Line.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Line.vi"/>
				<Item Name="Picture to Pixmap.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pictutil.llb/Picture to Pixmap.vi"/>
				<Item Name="Unflatten Pixmap.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pixmap.llb/Unflatten Pixmap.vi"/>
				<Item Name="IMAQ ArrayToImage" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ ArrayToImage"/>
				<Item Name="IMAQ Clear Overlay" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Clear Overlay"/>
				<Item Name="IMAQ Overlay Arc" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Arc"/>
				<Item Name="Color to RGB.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/colorconv.llb/Color to RGB.vi"/>
				<Item Name="IMAQ Overlay Line" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Line"/>
				<Item Name="IMAQ Overlay Points" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Points"/>
				<Item Name="IMAQ Point" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/IMAQ Point"/>
				<Item Name="IMAQ Overlay Text" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Text"/>
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
				<Item Name="BuildHelpPath.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/BuildHelpPath.vi"/>
				<Item Name="Check Special Tags.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Check Special Tags.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="Convert property node font to graphics font.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Convert property node font to graphics font.vi"/>
				<Item Name="Details Display Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Details Display Dialog.vi"/>
				<Item Name="DialogType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogType.ctl"/>
				<Item Name="DialogTypeEnum.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogTypeEnum.ctl"/>
				<Item Name="Error Code Database.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Code Database.vi"/>
				<Item Name="ErrWarn.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/ErrWarn.ctl"/>
				<Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
				<Item Name="Find Tag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find Tag.vi"/>
				<Item Name="Format Message String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Format Message String.vi"/>
				<Item Name="General Error Handler Core CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler Core CORE.vi"/>
				<Item Name="General Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler.vi"/>
				<Item Name="Get String Text Bounds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Get String Text Bounds.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="GetHelpDir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetHelpDir.vi"/>
				<Item Name="GetRTHostConnectedProp.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetRTHostConnectedProp.vi"/>
				<Item Name="Longest Line Length in Pixels.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Longest Line Length in Pixels.vi"/>
				<Item Name="LVBoundsTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVBoundsTypeDef.ctl"/>
				<Item Name="LVRectTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVRectTypeDef.ctl"/>
				<Item Name="Not Found Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Not Found Dialog.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Set Bold Text.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set Bold Text.vi"/>
				<Item Name="Set String Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set String Value.vi"/>
				<Item Name="Simple Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Simple Error Handler.vi"/>
				<Item Name="TagReturnType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/TagReturnType.ctl"/>
				<Item Name="Three Button Dialog CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog CORE.vi"/>
				<Item Name="Three Button Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog.vi"/>
				<Item Name="Open File+.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Open File+.vi"/>
				<Item Name="Read File+ (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read File+ (string).vi"/>
				<Item Name="compatReadText.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatReadText.vi"/>
				<Item Name="Close File+.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Close File+.vi"/>
				<Item Name="Find First Error.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find First Error.vi"/>
				<Item Name="Set Pen State.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Set Pen State.vi"/>
				<Item Name="imagedata.ctl" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/imagedata.ctl"/>
				<Item Name="TCP Listen.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/TCP Listen.vi"/>
				<Item Name="Internecine Avoider.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/Internecine Avoider.vi"/>
				<Item Name="TCP Listen List Operations.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/TCP Listen List Operations.ctl"/>
				<Item Name="TCP Listen Internal List.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/TCP Listen Internal List.vi"/>
				<Item Name="float64Scalar.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/std_msgs/subs/float64Scalar.vi"/>
				<Item Name="float64Array.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/std_msgs/subs/float64Array.vi"/>
				<Item Name="add_float64.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/std_msgs/add_float64.vi"/>
				<Item Name="add_quaternion.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/geometry_msgs/add_quaternion.vi"/>
				<Item Name="add_point.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/geometry_msgs/add_point.vi"/>
				<Item Name="add_vector3.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/geometry_msgs/add_vector3.vi"/>
				<Item Name="TopicDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/Console/Servers/ServerSubs/TopicDef.ctl"/>
				<Item Name="ROS_Topic_Close.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/ROS_Topic_Close.vi"/>
				<Item Name="NI_PackedLibraryUtility.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/LVLibp/NI_PackedLibraryUtility.lvlib"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="CheckBuildFolder.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/CheckBuildFolder.vi"/>
				<Item Name="Dflt Data Dir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Dflt Data Dir.vi"/>
				<Item Name="GetAllPaths.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/Console/GetAllPaths.vi"/>
				<Item Name="GetErrCodes.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/GetErrCodes.vi"/>
				<Item Name="_ROSDefinition.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/_ROSDefinition.vi"/>
				<Item Name="GetQueueValue.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/GetQueueValue.vi"/>
				<Item Name="_ROSControl.ctl" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/_ROSControl.ctl"/>
				<Item Name="GetServerVIName.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/GetServerVIName.vi"/>
				<Item Name="NodifyROS.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/NodifyROS.vi"/>
				<Item Name="ROSToQueue.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/Console/Servers/ServerSubs/ROSToQueue.vi"/>
				<Item Name="GetWriteQueue.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/GetWriteQueue.vi"/>
				<Item Name="GetFIFOQueue.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/GetFIFOQueue.vi"/>
				<Item Name="AddToQueue.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/AddToQueue.vi"/>
				<Item Name="GetROSfromTopic.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/GetROSfromTopic.vi"/>
				<Item Name="CheckForNewTopic.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/CheckForNewTopic.vi"/>
				<Item Name="ROS_Topic_Close_Primitive.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/ROS_Topic_Close_Primitive.vi"/>
				<Item Name="ROS_Topic_Init.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/ROS_Topic_Init.vi"/>
				<Item Name="WaitForStartup.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/WaitForStartup.vi"/>
				<Item Name="GetTagsForPreferences.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/GetTagsForPreferences.vi"/>
				<Item Name="CleanupString.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/CleanupString.vi"/>
				<Item Name="ConvertVItoHTML.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/ConvertVItoHTML.vi"/>
				<Item Name="GetLogFilePath.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/LogFileCodes/GetLogFilePath.vi"/>
				<Item Name="SaveReadPrefs.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/SaveReadPrefs.vi"/>
				<Item Name="AddToOldMasters.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/AddToOldMasters.vi"/>
				<Item Name="RedefineMasterIP.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/RedefineMasterIP.vi"/>
				<Item Name="GetURI&amp;Port.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/GetURI&amp;Port.vi"/>
				<Item Name="CheckMasterConnection.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/CheckMasterConnection.vi"/>
				<Item Name="GetTopicNode_etc.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/GetTopicNode_etc.vi"/>
				<Item Name="StartSeparateServer.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/StartSeparateServer.vi"/>
				<Item Name="getOpenPort.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/getOpenPort.vi"/>
				<Item Name="CheckNodeName.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/CheckNodeName.vi"/>
				<Item Name="ROS_Topic_Write.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/ROS_Topic_Write.vi"/>
				<Item Name="ROS_Topic_Write_Primitive.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/ROS_Topic_Write_Primitive.vi"/>
				<Item Name="prependLength.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/prependLength.vi"/>
				<Item Name="ROS_Topic_Read.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/ROS_Topic_Read.vi"/>
				<Item Name="ROS_Topic_Read_Primative.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/ROS_Topic_Read_Primative.vi"/>
				<Item Name="parse_float64_scalar.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_float64_scalar.vi"/>
				<Item Name="parseErrorCheck.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/subs/parseErrorCheck.vi"/>
				<Item Name="parse_float64.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/parse_float64.vi"/>
				<Item Name="parse_float64_array.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_float64_array.vi"/>
				<Item Name="parse_i8_scalar.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_i8_scalar.vi"/>
				<Item Name="parse_int8.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/parse_int8.vi"/>
				<Item Name="parse_i8_array.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_i8_array.vi"/>
				<Item Name="Quat_to_PRY.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/conversions/Quat_to_PRY.vi"/>
				<Item Name="parse_Odometry.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/nav_msgs/parse_Odometry.vi"/>
				<Item Name="parse_vector3.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/geometry_msgs/parse_vector3.vi"/>
				<Item Name="parse_twist.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/geometry_msgs/parse_twist.vi"/>
				<Item Name="parse_twistWithCovariance.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/geometry_msgs/parse_twistWithCovariance.vi"/>
				<Item Name="parse_quaternion.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/geometry_msgs/parse_quaternion.vi"/>
				<Item Name="parse_point.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/geometry_msgs/parse_point.vi"/>
				<Item Name="parse_pose.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/geometry_msgs/parse_pose.vi"/>
				<Item Name="parse_poseWithCovariance.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/geometry_msgs/parse_poseWithCovariance.vi"/>
				<Item Name="parse_string_scalar.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_string_scalar.vi"/>
				<Item Name="parse_string_array.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_string_array.vi"/>
				<Item Name="parse_string.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/parse_string.vi"/>
				<Item Name="parse_time_scalar.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_time_scalar.vi"/>
				<Item Name="parse_time_array.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_time_array.vi"/>
				<Item Name="parse_time.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/parse_time.vi"/>
				<Item Name="parse_u32_scalar.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_u32_scalar.vi"/>
				<Item Name="parse_u32_array.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/subs/parse_u32_array.vi"/>
				<Item Name="parse_uint32.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/parse_uint32.vi"/>
				<Item Name="parse_header.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/std_msgs/parse_header.vi"/>
				<Item Name="boolScalar.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/std_msgs/subs/boolScalar.vi"/>
				<Item Name="add_bool.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/std_msgs/add_bool.vi"/>
				<Item Name="boolArray.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/std_msgs/subs/boolArray.vi"/>
				<Item Name="add_pose.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/geometry_msgs/add_pose.vi"/>
				<Item Name="PRY_to_Quat.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageParsing/conversions/PRY_to_Quat.vi"/>
				<Item Name="add_twist.vi" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/MessageBuilding/geometry_msgs/add_twist.vi"/>
				<Item Name="_ROSDirection.ctl" Type="VI" URL="/&lt;vilib&gt;/Tufts CEEO ROS for LabVIEW Software/ROS/Code/SubVIs/_ROSDirection.ctl"/>
			</Item>
			<Item Name="user.lib" Type="Folder">
				<Item Name="add_pose_stamped.vi" Type="VI" URL="/&lt;userlib&gt;/ROS for LabVIEW Software/ROS/MessageBuilding/geometry_msgs/stamped/add_pose_stamped.vi"/>
				<Item Name="parse_PoseStamped.vi" Type="VI" URL="/&lt;userlib&gt;/ROS for LabVIEW Software/ROS/MessageParsing/geometry_msgs/stamped/parse_PoseStamped.vi"/>
			</Item>
			<Item Name="lvinput.dll" Type="Document" URL="/&lt;resource&gt;/lvinput.dll"/>
			<Item Name="nivissvc.dll" Type="Document" URL="nivissvc.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="lvanlys.dll" Type="Document" URL="/&lt;resource&gt;/lvanlys.dll"/>
			<Item Name="nivision.dll" Type="Document" URL="nivision.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="AriaDll.dll" Type="Document" URL="../../../../../labview/1511/zsControlSystem2.0/FromOtherProject/FromWSY/dll/AriaDll.dll"/>
			<Item Name="pose.ctl" Type="VI" URL="../../ROS-for-LabVIEW-Software/MoreExample/ctl/pose.ctl"/>
			<Item Name="Bool_msg.vi" Type="VI" URL="../States_lib/Running/Bool_msg.vi"/>
			<Item Name="Voice.lvclass" Type="LVClass" URL="../States_lib/Running/Voice.lvclass"/>
			<Item Name="Go to Voice Msg.lvclass" Type="LVClass" URL="../States_lib/Process State Messages/Go to Running Msg/Go to Voice Msg.lvclass"/>
		</Item>
		<Item Name="程序生成规范" Type="Build"/>
	</Item>
</Project>
